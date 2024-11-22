within ContextVariabilityManager.Examples;
package CoffeeMaker "An example using FeaturePlace and FeatureTransitionConditionEvent for feature management."

annotation (
    Documentation(info = "<html>
      <h1>CoffeeMaker Model</h1>
      <p>This model represents a coffee maker with three main features: Brewing, Grinding, and Steaming.</p>
      <p>The model utilizes a Feature Petri Net (PN) structure to simulate the transitions between states based on user input.</p>
      <h2>Model Components:</h2>
      <ul>
        <li><b>Feature Places</b>: Brewing, Grinding, Steaming</li>
        <li><b>Feature Transitions</b>: Start and Stop transitions for each feature</li>
        <li><b>User Input</b>: Simulated using BooleanStep blocks to trigger transitions at specific times</li>
      </ul>
      <h2>Triggering Logic:</h2>
      <p>The transitions are controlled using specific time events to simulate user interactions, ensuring the coffee maker can perform different functions sequentially or simultaneously as needed.</p>
    </html>"));
end CoffeeMaker;
