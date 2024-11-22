---
layout: default
title: Overview
nav_order: 1
---

# ContextVariabilityManager

A powerful Modelica tool that facilitates **variability management** using **modular and context-driven control logic**, enabling scalable and adaptable system designs.

## I. Introduction

In adaptive systems, components often respond dynamically to changing contexts—whether these contexts are time-based (e.g., day and night cycles) or resource-driven (e.g., fluctuating energy availability). However, most modeling languages, including Modelica, lack support for **Context-oriented Programming (COP)**, a paradigm for modular, flexible, and adaptable system behavior. COP allows models to adapt to contexts dynamically. It simplifies context definition (e.g., `when DayMode.isActive then ...`), reducing the need for cumbersome `if/else` statements and complex `when` clauses, enabling efficient variability management.

COP allows for variability to be managed via context and its state, as shown in the following diagram from <u>Cardozo, Nicolas, et al. "Context petri nets: Definition and manipulation." (2012).</u>

<img src="./assets/COP.jpg" style="zoom: 80%;" />

The benefits of COP include:

1.  Separation of Concerns
    * COP separates core logic from context-specific adaptations, keeping components clean and focused.
2.  Modularity and Reusability
    * Components can be reused in different contexts without changes, making them flexible and adaptable.
3.  Easier Maintenance and Scalability
    * Context-specific logic is isolated, making systems easier to update and expand.
4.  Improved Readability and Understandability
    * Centralized context definitions make the code clearer and easier to understand.

However, most modeling languages don’t support COP natively. **ContextVariabilityManager bridges this gap by bringing COP principles to Modelica**, enabling developers to build flexible, context-aware models with ease.

## II. Why This?

> Why not `if/else` or `when`?

Well, in small models, embedding control logic with `if/else` and `when` statements might be straightforward. However, as the number of contexts grows, this approach becomes harder to maintain and expand. Especially, defining parent-child or mutually exclusive contexts can quickly lead to a tangled mess of redundant code. While you might still be able to make sense of it after some time, others will likely struggle to understand and work with the model.

So, what if there was a simpler, cleaner, and more intuitive way to define contexts in natural language, while also supporting parent-child and mutually exclusive contexts that are easy to maintain and extend?

**ContextVariabilityManager** provides a solution to this problem by:

- allowing modelers to define context-specific configurations separately from the core model, enabling dynamic control of system behavior (such as energy-saving or performance modes) without altering the underlying Modelica components. This keeps the model clean, modular, and easy to maintain.

In ContextVariabilityManager, the base component (illustrated below) encapsulates each context or feature as a "place" with activation and deactivation transitions. **It abstracts the complexity of Petri Nets**, allowing modelers to **easily define contexts, activation conditions, parent-child relationships, and weak/strong inclusivity or mutual exclusivity**—no expertise in Petri Nets required. This leads to a simpler and more manageable design.

<img src="./assets/CFPN_component.png" style="zoom: 33%;" />

Below is a straightforward example of defining mutually exclusive features, **"brewing"** and **"grinding"**, with "brewing" given priority. This setup ensures that if "brewing" is active, "grinding" cannot be activated, and if "grinding" is already active, it will be deactivated if "brewing" becomes active.

```modelica
  FeatureWithConditionEvent grinding(
    activationCondition = startGrindingButton and (not brewing.isActive)  
  );
```

Below is an example of hierarchical contexts, "lowLoad" is defined as a child context of "normalMode", meaning that "lowLoad" can only activate if "normalMode" is already active. This parent-child relationship simplifies managing multiple layers of conditions.

```modelica
  ContextWithConditionEvent lowLoad(
    parentContext = "normalMode", 
    activationCondition = (hydrogenLevel >= 20.0 and hydrogenLevel < 40.0) and 										normalMode.isActive
  );
```
### Summary of Differences
| Aspect                | **ContextVariabilityManager (Using Petri Nets)**             | **Direct Definition (Using `if/else` & `when`) in Modelica** |
| --------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Modularity**        | High - Modular and encapsulated Petri Nets, better separation of concerns. | Low - Manual handling of conditions, more complex and less modular code. |
| **Maintenance**       | High - Clear separation of contexts and conditions, easy to read and maintain. | Low - `if/else` chains clutter the code, hard to read and maintain. |
| **Visualization**     | Can visualize Petri nets to understand state transitions.    | No built-in visualization for context transitions.           |
| **Context Relations** | Handles context relations (parent-child, inclusion, exclusion) elegantly. | Harder to manage, leading to redundant code.                 |
| **Error Handling**    | Clear structure and isolated transitions make error handling more intuitive. | Errors may be harder to trace due to complex chains and nested conditions. |

## III. Context Relationships

In complex systems, components often depend on each other. To model these dependencies, various relationships—such as **parent-child**, **weak inclusion**, **strong inclusion**, and **mutual exclusion**—allow flexible control over context activation and deactivation. These relationships help represent dynamic interactions and control structures within a system.

### 1. Parent-Child Relationship

In this relationship, a child context can only be activated if its parent context is active, establishing a dependency where the child's state is governed by the parent's.

```modelica
ContextA (
	activationCondition = ...
)

ContextB (
	parentContext = ContextA
	activationCondition = ... and ContextA.isActive
)
```

In this example, **ContextB** is only active when **ContextA** is active. This parent-child relationship enforces **ContextB's** activation based on **ContextA's** state.

### 2. Weak Inclusion

This relationship allows a context to be activated or deactivated independently, but its state can be influenced by the activation state of another context.

```modelica
ContextA (
  activationCondition = ...
)

ContextB (
  weakInclusionContext = ContextA
  activationCondition = ... or ContextA.isActive
)
```

In this example, the activation/deactivation of **ContextA** influences the state of **ContextB**, but **ContextB** retains the freedom to activate or deactivate independently of **ContextA**.

### 3. Strong Inclusion

Here, two contexts are tightly coupled, meaning the activation or deactivation of one directly triggers the state change of the other, creating a mutual dependency.

```modelica
ContextA (
  strongInclusionContext = ContextB
  activationCondition = ... or ContextB.isActive
)

ContextB (
  strongInclusionContext = ContextA
  activationCondition = ... or ContextA.isActive
)
```

In this example the activation or deactivation of **ContextA** or **ContextB** will directly trigger the activation or deactivation of the other.

### 4. Mutual Exclusion (and Priority)

This relationship ensures that two contexts cannot be active simultaneously, where activating one context deactivates the other, and priority can be assigned to manage which context takes precedence.

```modelica
ContextA (
  activationCondition = ...
)

ContextB (
  exclusionContext = ContextA
  activationCondition = ... and not ContextA.isActive
)
```

In this example, **ContextB** can only be activated if **ContextA** is not active. If **ContextA** is activated, **ContextB** will automatically deactivate.

## IV. Integration with Modelica

ContextVariabilityManager serves as a **Control Layer** that manages system variability, leveraging modular **Petri Nets** to represent different contexts and manage state transitions. This layer dynamically configures Modelica models in the **System Layer** in response to environmental states or operational requirements. The diagram below illustrates this layered architecture, with ContextVariabilityManager providing adaptive control over the System Layer’s behavior.

<img src="./assets/CFPN_application.png" style="zoom:80%;" />

ContextVariabilityManager is a Modelica library built with a structured design that extends `PNlib` and can be imported into any Modelica environment. Developers can utilize the components in the `Composite` package to create custom control logic.

```
ContextVariabilityManager
│
├── Components
│   ├── CFPNCore
│   │   ├── DiscretePlace
│   │   ├── ConditionEventTransition
│   │   └── TimeEventTransition
│   │
│   ├── ContextPN
│   │   ├── ContextPlace
│   │   ├── ContextTransitionTimeEvent
│   │   └── ContextTransitionConditionEvent
│   │
│   ├── FeaturePN
│   │   ├── FeaturePlace
│   │   ├── FeatureTransitionTimeEvent
│   │   └── FeatureTransitionConditionEvent
│   │
│   └── Composite
│       ├── ContextWithTimeEvent
│       ├── ContextWithConditionEvent
│       ├── FeatureWithTimeEvent
│       └── FeatureWithConditionEvent
│
├── Examples
│   ├── SmartHome
│   ├── CoffeeMaker
│   └── GreenIT
│
└── CaseStudies
    ├── CarSharingSystemCaseStudy
    └── ElectricGridCaseStudy
```

## V. FAQ

If you're interested, I have some valuable insights to share with you.

### 1. What Is The Difference Between Context and Feature?

In systems modeling, **contexts** define the broader state or environment in which a system operates, governing its behavior at any given moment. They are dynamic and can change in response to specific conditions, influencing the activation of other components. **Features**, on the other hand, are specific properties or functions of a system that vary within a context, like specific tasks or capabilities.

In Modelica, **contexts** are more commonly used to represent dynamic system states, while **features** can be applied for discrete functions, like a `brewing` or grinding operation in a `CoffeeMachine`, where physical equations aren't necessary.

In summary, **contexts** shape the system’s environment and behavior, while **features** define its capabilities within that environment.

### 2. How Does the Internal Logic Work?

In the base component, each context or feature is represented by a *place* with *activation* and *deactivation transitions*. The token count of the place is either 0 or 1—0 means the context is inactive, and 1 means it's active.

Here’s where it gets tricky. In Modelica, for a time-based context like `when t > 4`, the activation happens at `t = 4` and only triggers once. But for condition-based contexts like `when hydrogenLevel > 20`, activation keeps triggering as long as the condition holds. This constant triggering can hurt performance, and it also means the token count doesn’t toggle between 0 and 1—it just keeps increasing.

To solve this, I modified the Petri Net logic in the base component so the token count always stays 0 or 1. Whether it’s a time-based or condition-based trigger, the context is active when the token count is 1 and inactive when it’s 0. Simple and consistent!

### 3. Why Not Use Inhibitor Arcs?

Great question! I did consider inhibitor arcs but ran into two major issues.

1. **Dynamic Connections in Modelica**: To handle mutual exclusivity with inhibitor arcs, each component would need to dynamically create connections. For example, if `Context 1` and `Context 2` are mutually exclusive, and `Context 1` has priority, the place for `Context 1` would need to connect to the activation and deactivation transitions of `Context 2`. Now, imagine you have three, five, or even ten contexts, all with varying priorities and mutual exclusions—how could the base component dynamically adapt itself? Unfortunately, Modelica doesn’t support dynamically adding connectors like this, which makes scaling this approach impractical.

<img src="./assets/CFPN_with_IA.png" style="zoom: 33%;" />

2. **Loss of Encapsulation**: If modelers had to manually connect these inhibitor arcs, the Petri Net mechanics wouldn’t stay hidden. That defeats the purpose of ContextVariabilityManager. My goal is to provide a modular, easy-to-use tool where modelers don’t need to understand the underlying Petri Net logic.

Instead, I came up with a more intuitive way to handle mutual exclusivity while keeping the flexibility. As shown in the `Grinding` and `Brewing` example, users can define priorities and exclusivity easily, without needing to dive into Petri Net details.

