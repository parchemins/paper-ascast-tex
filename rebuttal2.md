We thank reviewers for their thorough reading and interesting
comments. We hope that our response will clarify their interrogations.

# Reviewer 1

## Motivation and practical application:
Our starting point is about minimizing response time of locating
content in geo-distributed infrastructures. Each time someone looks
for a particular content, a first node is reached to determine its
location and then, the content is retrieved from a second node
[1]. "Retrieving a content location may actually take more time than
retrieving the content itself".

For instance, let us consider Alice from Vienna who wants to download
a video. She first needs to know where to retrieve it from, and so
asks a content location service. If the latter is centralized and
hosted far away in Australia, the round-trip to interact with the
location service is detrimental, especially when the video is actually
stored close to Vienna.

One might think that distributing the indexing service using DHTs
would be sufficient to avoid this pitfall. However, DHTs do not
collocate content and location services. Therefore, despite having a
DHT node in Vienna, the one that actually knows where to find the
video Alice is looking for is still in Australia. Hence, the
interaction with the location service remains time-consuming.

Using AS-cast, each node in charge of maintaining content locations
knows at any time the closest location for a particular content.
Alice contacts her Vienna location service then downloads the video
from her closest host, hence improving quality of service.

AS-cast is not limited to content indexing, and generalizes well to
any replicated service. It even constitutes an efficient way to
perform multi-destinations shortest path in dynamic graphs.

**Action:** Slightly revise the introduction to instantiate this
Vienna example and complement the description of figures to further
help the reader.

## Simulations vs emulations vs in-vivo:
PeerSim, despite being old, remains a simple and flexible framework to
run large scale simulations in comparison to Splay, Mininet etc.  It
fits our goal of isolating the behavior of our protocol under desired
circumstances.

We focus our experiments on link latency. Other network conditions
such as hardware limitations, hardware heterogeneity, packet loss,
link congestion, would indeed increase convergence time, but we expect
it to remain in the same order of magnitude when not catastrophic.

Nevertheless, we agree that more realistic configurations are of
interest. We leave this as future work, where we would replace the DHT
of IPFS by AS-cast, and deploy it on a real distributed
infrastructure.

## Comparison against state-of-the-art:
While previous works proposed such comparisons [1], we voluntarily
discard them as they have well-identified shortcomings: Centralized
and DHT approaches do not collocate content and location services,
leading to slow response time; vector-based routing and replicated
stores flood the whole network at each event; timeout-based, random
walks, and spanning forests are cycle-based which never-endlessly
floods (part of) the network.

## Figure 7 time:
The time reported on Figure 7 corresponds to the simulated one. A
cycle is a simulated millisecond.


# Reviewer 2

## Centralized and DHT
Please, read the first anwser provided to Reviewer 1.

## Node failures:
Algorithm 3 handle changes in infrastructures.  "Removing a node is
equivalent to removing all its edges". Therefore, "What happens if
this direct parent fails?": Algorithm 3, line 4 states that this event
is equivalent to a possible source deletion. The detecting node
propagates the changes to its neighbors accordingly.

To detect failures, we indeed assume a low level mechanism, such as
heartbeats. Since many other running protocols benefit from provided
failure detection, we do not consider it as an overhead of our
protocol.

**Action:** Clarify this requirement and the implication on the
overhead.

## Scenarios 3e and 5e
Figure 3 illustrates the challenge of maintaining consistent
information.  Figure 5 shows that Node C cannot distinguish the two
scenarios.  The node assumes the worst outcome and propagates delete
messages in both cases, that would be true in Figure 3f, but false
positives in Figure 5f. AS-cast guarantees that every node converges
to its proper partition afterwards.

## First evaluation practicability
The topology is indeed arbitrary as we do not find any real
geo-distributed topology reaching such a scale of 10K nodes.  We
thought of instantiating GEANT multiple times but this remains
arbitrary.

## About worst-case scenario
Let us consider a chained set of Z nodes [A-Z] and the sequential
creation of partitions, the number of messages is: 25×2 + 24×2+ … +
1×2 = O(2×Z^2).

When creating all partitions in parallel, the number of messages is
only: 2×25.

## Packets size
We agree that transferred bytes would be of interest, especially to
compare with other approaches in more realistic settings as we plan in
future work.

## Single link between continents
We agree that this scenario is unrealistic; and also that partitions
may span multiple continents. AS-cast would work in such scenario.
Nevertheless, this experiment aims to demonstrate that AS-cast behaves
correctly in case of physical partitions. We find this result most
interesting since decentralized protocols often fail in such context.


# Reviewer 3

## Content indexing formal problem 
We chose to abstract the content indexing challenge as a more general
partitioning problem and formalize it this way (see also first answer
to Reviewer 1).

## Scope predicate
We agree that predicates need another constraint to qualify the
broadcast as scoped broadcast. Although we leave this as future work.

## Black-and-white
**Action:** We agree and make colored figures black-and-white
friendly.

## Crash recovery
Crashes may have immediate impact on neighboring nodes.  Therefore,
nodes always restart anew, retrieving and propagating relevant
information again.

[1] https://hal.archives-ouvertes.fr/hal-02190125/file/tnsm.pdf

