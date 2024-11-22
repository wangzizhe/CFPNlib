---
layout: default
title: Integration with Modelica
parent: Overview
nav_order: 4
---

# IV. Integration with Modelica

ContextVariabilityManager serves as a **Control Layer** that manages system variability, leveraging modular **Petri Nets** to represent different contexts and manage state transitions. This layer dynamically configures Modelica models in the **System Layer** in response to environmental states or operational requirements. The diagram below illustrates this layered architecture, with ContextVariabilityManager providing adaptive control over the System Layer’s behavior.

<img src="../../assets/CFPN_application.png" style="zoom:80%;" />

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