within CFPNlib.Examples;

package GreenIT "An example using ContextPlaceNested and ContextTransitionConditionEvent for hierarchical context management."

  annotation(
    Documentation(info = "<html>
      <h1>Smart GreenIT Model</h1>
      <p>This model represents a smart energy management system with hierarchical context handling. It is designed to optimize power usage based on hydrogen availability and workload demands.</p>
      <p>The model utilizes a Context Feature Petri Net (CFPN) structure with nested contexts for different operational modes and load levels.</p>
      <h2>Model Components:</h2>
      <ul>
        <li><b>Context Places</b>: Energy Saving Mode, Normal Mode, Performance Mode with Low, Medium, and High Load levels</li>
        <li><b>Context Transitions</b>: Condition-based transitions for activation and deactivation of each mode</li>
        <li><b>Input Levels</b>: Hydrogen level input triggers transitions based on resource availability</li>
      </ul>
      <h2>Triggering Logic:</h2>
      <p>Transitions are activated through condition-based triggers to switch between modes, providing adaptable energy consumption levels in response to real-time hydrogen availability and workload.</p>
    </html>")
  );

end GreenIT;
