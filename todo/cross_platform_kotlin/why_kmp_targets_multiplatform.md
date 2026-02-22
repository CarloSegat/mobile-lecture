4. The Core Implication for Kotlin Multiplatform (KMP)
This architecture explains why KMP targets Objective-C as its bridge to iOS. Since Swift must go through the Objective-C Runtime to use most Apple frameworks, a Kotlin→Objective-C bridge ensures maximum compatibility.

The "lossy" translation problem occurs because Kotlin's modern features have no equivalent in the simpler, dynamic Objective-C model, which is why tools like SKIE are needed to generate better Swift interfaces.