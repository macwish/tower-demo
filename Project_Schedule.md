### 日程安排摘要

---

### Day 1 [24日 16:00 - 25日 16:00]
  - 分析需求 [model 逻辑关系分析]                                 [done]
  - 整理需求 [mindnode, omnigraffle]                            [done]
  - 创建 event model 和 其它基础 models [设置 models relations]  [done]

### Day 2-3 [25日 16:00 - 27日 16:00]
  - 设计并实现 ACL 权限控制相关 models 和逻辑.               [done]
  - 实现基础 models 访问 (e.g: user#show, project#show).  [done]
  - 实现 event push.                                     [done]
    * via WebSocket (ActionCable)                       [done]
    * async events queue (ActiveJob)                    [done]
    * handle model ActiveRecord callbacks               [done]
  - 实现 events_controller#index 接口数据输出.             [done]

### Day 4-5 [27日 16:00 - 29日 16:00]
  - UI                                                  [done]
  - Rspec 测试 models and controllers.                   [done]

### Day 6 [29日 16:00 - 30日 16:00]
  - Rspec 测试 models and controllers.                    [done]
  - debug                                                 [done]
  - commit to github                                      [done] 

<br>
---

### 作业要求整理

  1. 在 Github 上创建一个 public 仓库,并在这个仓库里进行开发;  
  
   > [ok] 不过, 貌似过程没有在 github 上进行..
   
  2. 实现动态页面关于「任务」的数据展示(对页面样式无要求),可以持续加载;

   > [ok] WebSocket 实现动态的, 持续的, 无刷新的加载
   
  3. 设计 Event(动态模型),以及其它所需的基础模型;

   > [ok] 连带 event model 和 基础 model 等, 一共 14 models
   
  4. 设计并完成 events_controller#index 接口,该接口返回回顾页面的数据,默认 50 条; 

   > [ok] 默认 50条 (没有做分页)
   
  5. 尽可能的使用 Rspec 完成 Model 层以及 Controller 层的测试用例。

   > [ok] 所有相关测试用 Rspec 完成

<br>

### 需要实现的(Todo 相关的) Events 类型

1. 创建任务          [ok]
2. 删除任务          [ok]
3. 完成任务          [ok]
4. 给任务指派完成者    [ok]
5. 修改任务完成者     [ok]
6. 修改任务完成时间    [ok]
7. 评论任务          [ok]

