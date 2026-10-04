# Save workouts to Apple Health (one-time Shortcut setup)

A web app can't write to Apple Health directly. So the workout app hands each workout to a small Shortcut on your iPhone, and the Shortcut logs it in Health. You set this up once (about 5 minutes).

## What the app sends

When you tap **❤️ Save to Apple Health** (on the finish screen, on the "ended early" summary, or in a day's details on the calendar), the app opens:

`shortcuts://run-shortcut?name=Log%20Valerie%20Workout&input=text&text=<workout details>`

The workout details are text like this:

```json
{
  "type": "Traditional Strength Training",
  "name": "Valerie's Workout · Upper Body Pull / Arms",
  "start": "2026-10-04T09:30:00-07:00",
  "end": "2026-10-04T10:05:00-07:00",
  "startText": "Oct 4, 2026, 9:30 AM",
  "durationMin": 35,
  "calories": 140,
  "percentDone": 100,
  "lbLifted": 2450
}
```

Calories are an estimate: about 4 per minute (moderate strength training, about 3.5 METs for someone around 150 lb).

## Build the Shortcut

1. Open the **Shortcuts** app (white icon with a pink and blue shape). If you don't have it, get it free from the App Store.
2. Tap the **Shortcuts** tab at the bottom, then tap **+** in the top right corner. A new, empty shortcut opens.
3. Tap the name at the top ("New Shortcut"), tap **Rename**, and type exactly: **Log Valerie Workout** (capital L, V and W, single spaces). Tap **Done** on the keyboard. The name has to match exactly or the app can't find it.
4. Tap the search bar at the bottom (**Search Actions**) and type **Get Dictionary from Input**. Tap it to add it.
   - It should read "Get dictionary from **Shortcut Input**". If the blue word says "Input" instead, tap it and choose **Shortcut Input**.
   - A line like "Receive **Any** input from **Nowhere**" may appear at the top. Leave it as it is. The app's link still sends the text in.
5. Get the start time:
   - Search **Get Dictionary Value** and add it. It reads "Get **Value** for **Key** in **Dictionary**".
   - Tap **Key** and type **start**. Make sure the last blue word is **Dictionary** (the result of step 4).
   - Search **Set Variable**, add it, tap **Variable Name** and type **Start**.
6. Get the length:
   - Add **Get Dictionary Value** again. Tap **Key** and type **durationMin**.
   - Tap its last blue word and pick **Dictionary** (from step 4) if it shows something else.
   - Add **Set Variable** and name it **Minutes**.
7. Get the calories:
   - Add **Get Dictionary Value** again. Key **calories**, Dictionary from step 4.
   - Add **Set Variable** and name it **Calories**.
8. Search **Log Workout** (it's under Health) and add it.
   - Tap the workout type (it may show "Type" or "Running") and choose **Traditional Strength Training**. Use the search box if you can't see it.
   - Tap the small arrow (**›** / **Show More**) on the action to see the other fields.
   - **Date**: tap it, tap **Select Variable** (or the variable bar above the keyboard), and choose **Start**. If it won't accept it, tap the Start bubble and set its type to **Date**.
   - **Duration**: tap the number, choose the **Minutes** variable, and make sure the unit says **min**.
   - **Calories**: tap the number, choose the **Calories** variable, and make sure the unit says **kcal** (or "Cal").
9. Tap **Done** (top right). The shortcut is saved.

## First run

1. Open the workout app and tap **❤️ Save to Apple Health** after a workout.
2. iPhone asks to open it in Shortcuts. Tap **Open**.
3. The first time, Health asks if Shortcuts may save workouts. Turn it on and tap **Allow**. (If you miss it: open the **Health** app, tap your picture, then **Privacy › Apps › Shortcuts**, and turn on **Workouts**.)
4. Check it: in the **Health** app, tap **Browse › Activity › Workouts**. You'll see "Traditional Strength Training" with the time, minutes and calories.

The button then reads **✓ Saved to Apple Health**, and the day on the calendar shows "❤️ Saved to Apple Health". Tap it again only if you want a second copy.

## If something goes wrong

- **"Shortcut not found"**: the name doesn't match. Rename it to exactly **Log Valerie Workout**.
- **Wrong time in Health**: Health's Log Workout action has a Date (start) field but no End field, so the app sends the start time plus the length. If the Date is still wrong, use Plan B:
  - Delete the Start steps (step 5).
  - Add **Adjust Date**. Set it to **Subtract** the **Minutes** variable, unit **minutes**, from **Current Date**.
  - In Log Workout, set **Date** to **Adjusted Date**.
  - Or leave Date empty. Health then uses the time you tapped the button as the start, and the length still comes out right.
- **No calories**: leave Calories empty. Health will still log the workout and minutes.
