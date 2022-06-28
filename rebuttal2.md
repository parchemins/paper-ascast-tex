We thank reviewers for their thorough reading and interesting
comments. We hope that our response will clarify their interrogations.

# Reviewer 1

## Motivation and applications:
Our starting point is about minimizing response time of locating
content in geo-distributed infrastructures. When looking for a
content, a node is reached to determine its location, then, the
content is retrieved from another node [1]. _"Retrieving a content
location may actually take more time than retrieving the content
itself"_.

Consider Alice from Vienna who wants to download a video. She must
know where to retrieve it from, therefore she asks a content location
service. If the latter is centralized and hosted faraway in Australia,
the round-trip to the service is detrimental, especially when the
video is actually stored close to Vienna.

Distributing location services using DHTs is insufficient: DHTs do not
collocate content and location services. Despite having a DHT node in
Vienna, the corresponding hash of the video may still be the charge of
the node in Australia. Therefore, interacting with the service remains
time-consuming.

AS-cast tackles this problem since every node maintaining content
locations always knows its closest location for a particular content.
Alice contacts her Vienna location service then downloads the video
from her closest host.

AS-cast is not limited to content indexing, and generalizes well to
any replicated service. It even constitutes an efficient way to
perform multi-destinations shortest path in dynamic graphs.

**Action:** Slightly revise Introduction using this example and
complement figure descriptions.

## Simulations vs emulations vs in-vivo:

PeerSim, despite old w.r.t. highlight solutions, remains a flexible
framework to run large scale simulations. It fits our goal of
isolating our protocol's behavior focusing on link latency.

Other network conditions (hardware limitations/heterogeneity, loss,
congestion…) would indeed increase convergence time, but we expect an
identical order of magnitude when not catastrophic.

Nevertheless, we agree more realistic configurations are of
interest. We leave this as future work: replace IPFS's DHT by AS-cast,
and deploy on real infrastructures.

## State-of-the-art comparison:
Previous works proposed such comparisons [1]. We discard them due to
their well-identified shortcomings: Centralized and DHT approaches do
not collocate content and location services, leading to slow response
time; vector-based routing and replicated stores flood the network at
each event; timeout-based, random walks, and spanning forests are
cycle-based which never-endlessly floods the network.

## Figure 7 time:
The time reported on Figure 7 is the simulated one. A cycle is a
simulated millisecond.


# Reviewer 2

## Centralized and DHT
Please, read the first answer provided to Reviewer 1.

## Node failures:
Algorithm 3 handles infrastructure changes.  _"Removing a node is
equivalent to removing all its edges"_.  Therefore, "What happens if
this direct parent fails?": Algorithm 3, line 4 triggers a _possible_
source deletion. The detecting node propagates the changes to its
neighbors accordingly.

To detect failures, we indeed assume a low level mechanism
(eg. heartbeats). Since many other running protocols benefit from it,
we do not consider it an overhead of AS-cast.

**Action:** Clarify requirements and overhead implications.

## Scenarios 3e and 5e
Figure 3 illustrates the challenge of consistency.  Figure 5
highlights the *challenge* that Node C *cannot* distinguish the two
scenarios.  The node assumes the worst and propagates delete messages:
rightfully in Figure 3f, wrongfully in Figure 5f. Afterwards, AS-cast
still ensures convergence.

## First evaluation practicability
The topology is indeed arbitrary as we do not find any real
geo-distributed topology reaching 10K nodes.  Instantiating GEANT
multiple times would remain arbitrary.

## Worst-case scenario
Consider [A..Z] chained nodes, and a sequential creation of
partitions, the number of messages is: 25×2 + 24×2 +…+ 1×2 = O(2×Z^2).
Whereas in parallel, the number of messages is only: 2×25.

## Packets size
We agree that transferred bytes would be interesting, especially to
compare with other approaches in realistic settings as we plan in
future work.

## Intercontinental link
We agree that this scenario is unrealistic.  Nevertheless, this
experiment aims to demonstrate that AS-cast behaves correctly when
physical partitions occur. We find this result most interesting since
decentralized protocols often fail in such context.


# Reviewer 3

## Content indexing problem 
We chose to abstract the content indexing challenge as a more general
partitioning problem and formalize it this way.

## Scope predicate
Any predicate would work: the scope of an always true predicate would
trivially be "all nodes".

## Crash recovery
Crashes may impact neighboring nodes immediately.  Therefore, nodes
always restart in fresh state, retrieving and propagating relevant
information again.



[1] https://hal.archives-ouvertes.fr/hal-02190125/file/tnsm.pdf
