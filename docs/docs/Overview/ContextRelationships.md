---
layout: default
title: Context Relationships
parent: Overview
nav_order: 3
---

# III. Context Relationships

In complex systems, components often depend on each other. To model these dependencies, various relationships—such as **parent-child**, **weak inclusion**, **strong inclusion**, and **mutual exclusion**—allow flexible control over context activation and deactivation. These relationships help represent dynamic interactions and control structures within a system.

## 1. Parent-Child Relationship

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

## 2. Weak Inclusion

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

## 3. Strong Inclusion

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

## 4. Mutual Exclusion (and Priority)

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
