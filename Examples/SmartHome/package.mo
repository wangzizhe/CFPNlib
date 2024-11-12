within CFPNlib.Examples;

package SmartHome "An example using ContextPlace and ContextTransitionTimeEvent for context management."

annotation(
    Documentation(info = "<html>
      <h1>SmartHome Model</h1>
      <p>This model represents an automated smart home system that adapts lighting, heating, and security settings based on the time of day.</p>
      <p>The model uses a Context Petri Net (CPN) structure with time-based contexts to dynamically adjust features in the home environment.</p>
      <h2>Model Components:</h2>
      <ul>
        <li><b>Context Places</b>: Day, Evening, Night</li>
        <li><b>SmartHome Features</b>:
          <ul>
            <li><b>Lighting Model</b>: Controls lighting based on time of day</li>
            <li><b>Heating Model</b>: Adjusts temperature settings in response to time context</li>
            <li><b>Security Model</b>: Activates or deactivates security settings depending on day or night context</li>
          </ul>
        </li>
        <li><b>Context Transitions</b>: Time-based transitions for activating and deactivating each context</li>
      </ul>
      <h2>Triggering Logic:</h2>
      <p>The transitions are governed by the time of day (day, evening, night), which activates or deactivates specific features to create an adaptive and responsive home environment.</p>
    </html>")
  );

end SmartHome;
