---
layout: default
title: Why This?
parent: Overview
nav_order: 2
---

# II. Why This?

> Why not `if/else` or `when`?

Well, in small models, embedding control logic with `if/else` and `when` statements might be straightforward. However, as the number of contexts grows, this approach becomes harder to maintain and expand. Especially, defining parent-child or mutually exclusive contexts can quickly lead to a tangled mess of redundant code. While you might still be able to make sense of it after some time, others will likely struggle to understand and work with the model.

So, what if there was a simpler, cleaner, and more intuitive way to define contexts in natural language, while also supporting parent-child and mutually exclusive contexts that are easy to maintain and extend?

**ContextVariabilityManager** provides a solution to this problem by:

- allowing modelers to define context-specific configurations separately from the core model, enabling dynamic control of system behavior (such as energy-saving or performance modes) without altering the underlying Modelica components. This keeps the model clean, modular, and easy to maintain.

In ContextVariabilityManager, the base component (illustrated below) encapsulates each context or feature as a "place" with activation and deactivation transitions. **It abstracts the complexity of Petri Nets**, allowing modelers to **easily define contexts, activation conditions, parent-child relationships, and weak/strong inclusivity or mutual exclusivity**—no expertise in Petri Nets required. This leads to a simpler and more manageable design.

<img src="../../assets/CFPN_component.png" style="zoom: 33%;" />

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

## Summary of Differences

| Aspect                    | **ContextVariabilityManager (Using Petri Nets)**             | **Direct Definition (Using `if/else` & `when`) in Modelica** |
| ------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| **Modularity**            | High - Modular and encapsulated Petri Nets, better separation of concerns. | Low - Manual handling of conditions, more complex and less modular code. |
| **Maintenance**           | High - Clear separation of contexts and conditions, easy to read and maintain. | Low - `if/else` chains clutter the code, hard to read and maintain. |
| **Visualization**         | Can visualize Petri nets to understand state transitions.    | No built-in visualization for context transitions.           |
| **Context Relationships** | Handles context relations (parent-child, inclusion, exclusion) elegantly. | Harder to manage, leading to redundant code.                 |
| **Error Handling**        | Clear structure and isolated transitions make error handling more intuitive. | Errors may be harder to trace due to complex chains and nested conditions. |