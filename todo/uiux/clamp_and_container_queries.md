https://medium.com/@deo_wetton/why-are-major-tech-companies-abandoning-px-and-rem-across-the-board-ff795a8fc1e6




This Medium article by Deo Wetton explores a significant shift in design engineering: the move away from traditional units like px (pixels) and even rem (root em) in favor of dynamic, viewport-relative, and fluid typography systems.
The core argument is that in 2025, the "fixed" nature of pixels and the "linear" nature of rems are failing to provide the level of responsiveness required for modern, diverse screen sizes.
1. Why Pixels (px) Are Being Abandoned
* Lack of Accessibility: Pixels are absolute units. If a user changes their browser’s default font size for accessibility reasons, layouts built with px often remain frozen, making the text unreadable for those with visual impairments.
* Screen Density Issues: With the massive variety in "Retina" and high-DPI displays, a single pixel is no longer a physical constant, leading to inconsistent rendering across devices.
2. The Trouble with rem
While rem was long considered the "gold standard" because it scales with browser settings, the author notes that major tech companies are finding it too linear.
* A rem unit scales everything at the same rate. This often results in "giant" headers on tablets or text that is still slightly too small on ultra-wide monitors.
* It requires developers to write dozens of "breakpoints" (@media queries) to manually adjust sizes for every possible device.
3. The Rise of "Fluid" and "Intrinsic" Design
Major companies (like Adobe, Stripe, and Apple) are shifting toward CSS Math Functions to create "fluid" layouts that calculate size automatically.
* clamp() is the New Standard: Instead of a fixed size, developers use font-size: clamp(1rem, 5vw, 2rem);. This defines a minimum, a preferred (dynamic) value, and a maximum size.
* Container Queries: Moving away from the "Viewport" (vw) and toward "Container" units (cqw). This allows a component to change its size based on the space it actually occupies on the screen, rather than the total width of the browser.
4. Why Tech Giants are Making the Switch
* Efficiency (Low Code): By using fluid units, companies can eliminate thousands of lines of media queries. The layout "breathes" and adjusts itself automatically.
* Future-Proofing: As foldable phones and wearable displays become more common, design systems must be "unit-agnostic" to look good on a 1-inch watch or a 50-inch TV.





What does this line acrually do? size: clamp(1rem, 5vw, 2rem);


Breakdown of the 3 Parts
1. 1rem (The Floor): The absolute smallest the value can get. No matter how tiny the screen (like an Apple Watch), the text will never be smaller than 1rem (typically 16px).
2. 5vw (The Engine): This is 5% of the Viewport Width. This is the "fluid" part. As the browser window gets wider, this value grows. 
3. 2rem (The Ceiling): The absolute largest the value can get. On a massive 4K monitor, the text will stop growing once it hits 2rem (typically 32px).

How it behaves in real-time
* On a small phone: 5% of the screen width might calculate to only 0.5rem. Since 0.5rem is less than your MIN, the browser ignores it and uses 1rem.
* On a tablet: 5% of the screen width might calculate to exactly 1.5rem. Since this is between your Min and Max, the font stays exactly at 1.5rem. As you drag the browser window, the font grows and shrinks smoothly.
* On a desktop: 5% of a huge screen might calculate to 4rem. Since 4rem is greater than your MAX, the browser ignores it and caps the size at 2rem.



What do you mean with container queries?




In simple terms, a Container Query allows a component to change its look based on the size of the box it is sitting in, rather than the size of the whole screen.

To understand why this is a big deal, you have to look at how we used to do things.

The Comparison: Media Queries vs. Container Queries
1. Media Queries (The Old Way)
* The logic: "If the entire phone screen is wider than 600px, make this text blue."
* The problem: Imagine you have a "Card" component (like a weather widget).
    * On the Home Screen, that card is full-width.
    * But in a Sidebar, that same card is very narrow.
    * With a Media Query, the card thinks: "The screen is huge! I should use my wide layout!" but it ends up looking crushed and broken because it's actually stuck in a tiny sidebar.
2. Container Queries (The Modern Way)
* The logic: "If my parent container is wider than 300px, change my layout."
* The solution: Now, the "Card" component is "self-aware."
    * If you drop it into a wide area, it expands and shows more detail.
    * If you drop it into a narrow column, it automatically switches to a compact list view.
    * The screen size doesn't matter; only the space the component has to live in matters. 

A Real-World Example: The "Bio" Card
Imagine a profile card with a picture on the left and text on the right.
* Standard Behavior: If the container is wide, the picture and text are side-by-side. 
* The Container Query Rule: "If my container becomes narrower than 250px, stack the picture on top of the text."
Why this is amazing for developers:
You only write the code for that card once. You can then reuse that card anywhere in your app—in a big hero section, a small footer, or a pop-up menu—and it will always "know" how to format itself perfectly.

