---
title:  "Backend Service Optimization Bottleneck"
date:   "2020-03-14 00:00:00+08:00"
tags: [backend, database]
pull_request_id: 1
---

<!-- 写在前面：雇主和雇员的本质关系是，雇主花钱购买雇员的时间来为其完成任务。面试，从雇主来说，是为了筛选得到符合要求的雇员；从雇员来说，是为了获得与自身实力匹配的职位与薪资。事实上，整个面试过程都是由人来进行主观判断，因此面试实际上给了雇员展现高于自身的实力而因此获得更高的职位与薪资的机会。一次好的面试，可以省下后续好几年为了升职所需要付出的努力。 -->

> 中文版在英文版之后。

# Backend Service Optimization Bottleneck

Let's take [rails](https://github.com/mpan-wework/interview-essentials-example/tree/master/rails-init) as example, backend service consists of [route](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/config/routes.rb), [controller](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/app/controllers/posts_controller.rb), [model](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/app/models/post.rb) and [database](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/db/migrate/20200314070746_create_posts.rb), along with necessary [job](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/app/jobs/application_job.rb) for non-blocking handling. A request, regardless of `rest`, `graphql` or `rpc`, is to be processed at an `endpoint` by a `controller`. The `controller` defines the flow, by calling `model` methods, which may involves `database`s, `cache`, `message queue`s, `job`s or external services, and finally returns the response. 

Code execution relies upon cpu and memory. It is encouraged to learn about language-specific garbage collection to write better code. In addition, some languages may support multi threads or coroutines.

`cache` is already in memory, so attention is to be paid at used memory size to avoid disaster.

`database` is ofter the main part for optimization, which spends time on file i/o, especially for write operation. It is commonly known that we need to add `index` for those columns in `where` clause. `eagar load` is adopted to dump all data into memory for later use to avoid querying multiple times. `lazy load` skips unnecessary operations until required. By utilizing `cache`，we can read data from memory instead of from disk within acceptable time range. Additionally, we can skip unnecessary locks.

External service communication is actually network requests. Similar to `database`, we can fetch data through batch API; we can borrow the concept of `lazy load` to send request when necessary; we can save data to `cache` and read it before expiration time. Moreover, we are supposed to encode and compress `request` and `response` body.

For operations with `database`, external service and `message queue`, it is advisable to enqueue them as asynchronous `job`s if applicable.

With above taken into consideration, the other alternatives could be adding `replica`, load balancing, switching to another language/framework.

# 后端服务优化瓶颈

以 [rails](https://github.com/mpan-wework/interview-essentials-example/tree/master/rails-init) 为例，后端服务由 [route](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/config/routes.rb)、[controller](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/app/controllers/posts_controller.rb)、[model](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/app/models/post.rb) 和 [database](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/db/migrate/20200314070746_create_posts.rb)组成，非阻塞任务还会有 [job](https://github.com/mpan-wework/interview-essentials-example/blob/master/rails-init/app/jobs/application_job.rb)。一个请求，无论是 `rest`、`graphql` 还是 `rpc`，经由一个 `endpoint` 的 `controller` 进行处理。`controller` 定义了流程，通过调用 `orm` 的 `model` 的方法, 和 `database`、`cache`、`message queue`、`job` 或者外部服务交互， 最终获得结果返回。

代码本身的执行主要瓶颈是 cpu 和 内存，其中通过了解语言相关的垃圾回收机制，使用好的写法可以稍微优化一些。支持多线程、协程的语言，可以通过相关特性进行优化。

`cache` 本身已经在内存里，只需要稍加注意 `cache` 的大小，做好灾备。

`database` 一般是重点优化部分，瓶颈本质是文件读写，尤其是写操作。添加索引，提高数据库操作的效率。减少数据库操作，比如 `eagar load` 解决 `N+1 query`，通过一次 query 把数据读入内存，后续都在内存中处理；又比如 `lazy load`，只在必要的时候进行数据库操作。避免全表更新，只更新必要的；通过存 `cache`，避免反复读操作。只在敏感的数据表操作加锁。

外部服务的瓶颈本质是网络 IO，采用思路与 `database` 比较相似，通过批量接口，一次拿回多个数据；通过 `lazy load`，只在必要的时候请求；通过存 `cache`，避免反复请求。此外，还需注意压缩 `request` 和 `response`。

以上谈到的 `database`、外部服务以及 `message queue` 等操作，如果在业务流程里可以接受异步执行，则可以通过异步 `job` 执行，以缩短处理请求的周期。

有了这样一些基本概念，写代码的时候及时注意，后续途径只有增加 `replica` 和负载均衡或者换语言换框架了。
