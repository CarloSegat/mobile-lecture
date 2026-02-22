In this Medium article, Ravi6997 makes a strong case for why gRPC (Google Remote Procedure Call) is becoming the go-to choice for high-performance iOS applications in 2025, moving beyond the traditional REST/JSON model.
The core argument is that as mobile apps become more data-intensive (especially with real-time AI features and complex syncing), the overhead of REST becomes a major bottleneck.
Key Takeaways & Technical Shifts
1. Binary vs. Text (The Protocol Buffers Advantage)
The author highlights that while REST uses JSON (human-readable text), gRPC uses Protocol Buffers (Protobuf)(binary format).
* Efficiency: Binary data is significantly smaller and faster to "serialize" (pack) and "deserialize" (unpack) than text.
* Type Safety: In iOS development, this means you get auto-generated Swift code from your .proto files. You no longer have to manually map JSON to Swift models, which eliminates "key-not-found" crashes.
2. HTTP/2 and Performance
The article explains that gRPC is built on HTTP/2, which allows for:
* Multiplexing: Your iOS app can send multiple requests over a single connection at the same time, rather than waiting for one to finish before starting the next.
* Header Compression: This reduces the "size" of the request itself, which is crucial for users on 3G/4G or unstable mobile networks.
3. Real-Time Streaming
A major highlight for 2025 is the shift toward bidirectional streaming. Unlike REST, where the client must always "ask" for data, gRPC allows a constant "open pipe" between the iPhone and the server. This is framed as essential for:
* Live activity updates.
* Instant messaging/chat.
* Real-time financial or sports data.
4. The "iOS 2025" Implementation
The author notes that implementation has become much easier with modern Swift tooling (Swift Package Manager support for gRPC-Swift). However, they warn of a learning curve:
* Infrastructure: Your backend must support gRPC; you can't just "switch" the iOS side alone.
* Debugging: Because the data is binary, you can't easily read the network traffic in tools like Proxyman without the proper schema definitions.
Final Verdict
The article concludes that for 2025, REST is still fine for simple apps, but if you are building an iOS app where latency and battery life are competitive advantages, migrating to gRPC is no longer optional—it is the modern standard.
Understanding gRPC vs REST This video is relevant because it provides a deep dive into how major tech companies like Lyft integrated gRPC into their iOS stacks to improve app speed and reliability.


In the video "gRPC & iOS at Lyft," Michael Arabella, an iOS engineer on the Mobile Infrastructure team, explains why and how Lyft transitioned from a traditional REST/JSON networking stack to gRPC and Protocol Buffers (Protobuf).
1. The Problem with the Old Stack (REST/JSON)
* Fragility: Lyft used YAML and Swagger to define endpoints, but these weren't a "single source of truth." [02:54] Often, the server and client would fall out of sync, leading to runtime crashes or decoding errors because JSON mapping is "fragile." [03:46]
* Manual Mapping: On iOS, they used a framework called "Mapper" to manually convert JSON dictionaries into Swift structs, which was tedious and error-prone. [01:37]
* Latency in Polling: For real-time data like a driver’s location, the app had to "poll" (ask the server every few seconds). [08:50] This created a lag between the driver's actual movement and what the user saw on the map. [09:01]
2. The Solution: Protocol Buffers (Protobuf)
* Strong Typing: Instead of JSON, they moved to Protobuf, which allows you to define models in a .proto file that looks like a Swift struct. [05:44]
* Code Generation: Using a tool called protoc, they automatically generate Swift files from these definitions. [07:06] This ensures that the server (Go/Python) and the client (Swift/Java) are always using the exact same data structures. [11:18]
* Efficiency: Protobuf is a binary format, making it much smaller and faster to send over the wire than text-based JSON. [07:23]
3. Why gRPC?
* Remote Procedure Call (RPC): gRPC allows the app to call a function on the server as if it were a local function in the code, handling all the encoding and decoding under the hood. [10:05]
* HTTP/2 & Streaming: gRPC uses HTTP/2, which supports Bi-directional Streaming. [17:06]
    * The "Push" Model: Instead of the app asking "where is the driver?", the server "pushes" the location to the app as soon as it changes. [09:11]
    * Benefits: This reduces latency, saves battery, and improves the user experience for real-time features. [23:18]
4. Implementation at Lyft
* Swift Support: Since Google’s Swift gRPC library was experimental at the time, Lyft worked closely with Google to upstream fixes and make it production-ready. [15:08]
* Custom Validation: Lyft open-sourced a tool to add Validation Rules directly to Protobuf files (e.g., ensuring a latitude value is between -180 and 180) to catch data errors early. [18:39]
* Abstraction Layers: They built wrapper modules so that most engineers don't even have to know they are using gRPC; they just call a generated Swift function and get a strongly-typed response back. [20:45]
5. Rollout Strategy
* Analytics First: Lyft began by piloting gRPC with Analytics data because it is high-traffic but low-risk. [22:12] They "shadowed" the data by sending it over both REST and gRPC to compare performance and payload sizes before a full rollout. [22:31]



what are the arguments of this guy? It contrasts the use of gRPC in ios no?

https://youtu.be/WpXs7e7kEoI?si=j-rgMV2mb02zB68Z


The video by ArjanCodes, titled "Now I Know Why Most People Don’t Use gRPC," provides a balanced view that contrasts with the "gRPC is the future" narrative. While he acknowledges the technical benefits mentioned in the previous Lyft video, he focuses heavily on the developer experience and architectural trade-offs that make many developers stick with REST.
1. Key Arguments Against (or Cautions About) gRPC
* Complexity for Web Clients: Arjan points out that because gRPC relies on HTTP/2, most modern web browsers cannot talk to it directly without a proxy (like grpc-web). [10:09] This adds a layer of infrastructure complexity that REST doesn't have.
* Code Generation Friction: gRPC forces a "Code Generation" workflow. [06:30] If the generated code is messy or lacks modern features (like type annotations in Python), it can be frustrating to work with and feels less "native" than handwriting your models. [14:24]
* Tight Coupling: Both the client and the server must have the exact same .proto file to communicate. [13:05] This creates a management headache: Do you store them in a shared repo? Duplicate them? This can lead to a "distributed monolith" where changing one service requires updating every other service immediately. [13:18]
* Human Readability: Unlike REST, where you can just open a browser or use a simple tool to see a JSON response, gRPC is binary. [17:53] Debugging requires special tools just to "read" what is being sent.
2. Where gRPC Wins (Agreement with Lyft)
Arjan agrees with the Lyft video on several technical points:
* Performance: Protobuf is smaller and faster than JSON. [06:16]
* Streaming: It is vastly superior for real-time data (like chat or live updates) because of its native support for bidirectional streaming. [15:03]
* Contract-First: Having a strict Protobuf file prevents "typo" bugs that are common in REST. [15:24]
3. The "It Depends" Conclusion
Arjan’s final stance creates a clear distinction for when to use each:
* Internal Service-to-Service: Use gRPC. When your Backend "Service A" talks to Backend "Service B," the performance and strict contracts are worth the setup time. [17:10]
* External/Public APIs (Web/Mobile): Use REST. It is more familiar, more flexible, and easier for external developers to integrate with. [17:47]
* The Hybrid Approach: He suggests a common pattern where internal microservices use gRPC, but an API Gateway converts those requests to REST for the outside world (like an iOS app or a browser). [18:14]
Contrast with the Lyft Video
While the Lyft video presented gRPC as the solution to their mobile networking problems (specifically for real-time driver tracking), ArjanCodes warns that for the average developer or smaller app, the "hidden costs" of maintaining the Protobuf files and the infrastructure might outweigh the speed benefits.


