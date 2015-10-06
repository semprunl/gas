GAS is lighweight entry level version of LIQID.

While LIQID focuses on clients with investable assets in excess of €100,000 and offers a mix of automated + human investment advise, GAS account minimum is €10,000 and it is completely automated.

## How it works

1. The first step in our methodology is to identify a broad set of diversified asset classes to serve as the building blocks for our portfolios. We determine the optimal mix of our chosen asset classes by solving the “Efficient Frontier” using Mean-Variance Optimization (MVO), the foundation of Modern Portfolio Theory. The Efficient Frontier represents the portfolios that generate the maximum return for every level of risk.

2. GAS then uses cost-effective, index-based Exchange-Traded Funds (ETFs) to represent each asset class. We periodically review the entire population of ETFs to identify the most appropriate ones to represent each of the recommended asset classes. We look for ETFs that minimize cost and tracking error, offer ample market liquidity, and minimize the lending of their underlying securities.

3. Once the Efficient Frontier has been established, it is necessary to pinpoint an investor’s risk tolerance in order to identify the ideal asset allocation for his or her needs. Rather than asking the typical 25 questions asked by financial advisors to identify an individual’s risk tolerance, GAS combed behavioral economics research to simplify our risk identification process to only a few questions.

4. Finally, we constantly monitor our clients’ portfolios and periodically rebalance each back to its target mix in an effort to optimize returns for their intended level of risk. After taking tax implications and trading costs into consideration, we rebalance when dividends from ETFs accrue, a deposit or a withdrawal has been made, or if movements in the portfolio's allocations justify a change.

## Project Architecture

##### Backend

GAS is decomposed into a set of collaborating services. Each service implements a set of narrowly, related functions.

Services communicate using either synchronous protocols such as HTTP/REST or asynchronous protocols such as AMQP.

Services are developed and deployed independently of one another.

Each service has its own database in order to be decoupled from other services. When necessary, consistency is between databases is maintained using either database replication mechanisms or application-level events.

####### Benefits of using microservices
1. Each microservice is relatively small
⋅⋅* Easier for a developer to understand
⋅⋅* The IDE is faster making developers more productive
⋅⋅* The web container starts faster, which makes developers more productive, and speeds up deployments
2. Each service can be deployed independently of other services - easier to deploy new versions of services frequently
3. Easier to scale development. It enables you to organize the development effort around multiple teams. Each (two pizza) team is responsible a single service. Each team can develop, deploy and scale their service independently of all of the other teams.
4. Improved fault isolation. For example, if there is a memory leak in one service then only that service will be affected. The other services will continue to handle requests. In comparison, one misbehaving component of a monolithic architecture can bring down the entire system.
5. Each service can be developed and deployed independently
6. Eliminates any long-term commitment to a technology stack

####### Drawbacks of using microservices
1. Developers must deal with the additional complexity of creating a distributed system.

⋅⋅* Developer tools/IDEs are oriented on building monolithic applications and don't provide explicit support for developing distributed applications.
⋅⋅* Testing is more difficult
⋅⋅* Developers must implement the inter-service communication mechanism.
⋅⋅* Implementing use cases that span multiple services without using distributed transactions is difficult
⋅⋅* Implementing use cases that span multiple services requires careful coordination between the teams

2. Deployment complexity. In production, there is also the operational complexity of deploying and managing a system comprised of many different service types.

3. Increased memory consumption. The microservices architecture replaces N monolithic application instances with NxM services instances. If each service runs in its own JVM (or equivalent), which is usually necessary to isolate the instances, then there is the overhead of M times as many JVM runtimes. Moreover, if each service runs on its own VM (e.g. EC2 instance), as is the case at Netflix, the overhead is even higher.

####### Alternative implementation
Alternatively GAS can be developed as a monolithic application and later on evolve to a microservices architecture in order to scale.

##### Technology stack

* Initial / Growth phase
⋅⋅* Ruby / Grape / Roar / ActiveRecord
⋅⋅* MySql / Postgres
..* REST
..* RabbitMQ

* Scale phase
⋅⋅* Embrace the JVM (Java, Scala, Clojure, etc)

##### Deployment infraestructure

* Each microservice should be package in a Docker container
* Each microservice should be deployed to Amazon EC2 Container Service (ECS) in order to be run across a cluster of Amazon EC2 instances.

##### Continuous delivery

Continuous Delivery makes it possible to continuously adapt software in line with user feedback, shifts in the market and changes to business strategy. Test, support, development and operations work together as one delivery team to automate and streamline the build, test and release process.

1. Commit is pushed
2. CI server/hosted solution executes build
3. If build is succesful a deployment stategy is executed, being staging, progressive production (only in a few instances) or production.
4. If build fails then the team is notified

##### Catalog of microservices
(All the data is managed by a team of financial product managers)

####### Asset Classes
Manages all the different asset classes and their properties such as portfolio allocation weights by investment tolerance level.

######### Available operations
* CRUD for Asset Class model and their associate allocation weights

####### ETFs
Manages all the different index-based exchange-traded funds.

######### Available operations
* CRUD for ETF model and their associate pricing and ROI history
* Buy ETF stocks through broker
* Sell ETF stocks through broker

####### Risk Tolerance Calculator
Calculates the risk tolerance of an investor based on their questionare answers.

######### Available operations
* CRUD for risk tolerance calculation data
* Calculate risk tolerance level

####### Asset allocation calculator
Calculates the allocation of portfolio assets based on the risk tolerance score.

######### Available operations
* CRUD for allocation calculation data
* Calculate asset allocations by risk tolerance score

####### Investor
Holds the investor access and contact data

######### Available operations
* CRUD
* Authentication

####### Portfolio
Holds the investor portfolio

######### Available operations
* CRUD

##### Example client common workflows

######### Opening an account:
1. Obtain user risk tolerance score: UI -> [RISK TOLERANCE CALCULATOR SERVICE]
2. Store user contact and auth data along with the RTS: UI -> [INVESTOR SERVICE]
3. Gets AUTH API KEY and redirect to Dashboard: [INVESTOR SERVICE] -> UI 

######### Asset class allocation and stocking porfolio:
1. Obtain asset allocation for current investor risk tolerance score: UI -> [ASSET ALLOCATION CALCULATOR SERVICE]
2. Display historical performance and predicted return: UI -> [ETF SERVICE] -> UI
3. If investor accepts then proceed to buy stocks: UI -> [ETF SERVICE] | [ETF SERVICE] --> [PORTOFOLIO SERVICE]