---
title:  "CSS Specificity and CSS Modules"
date:   "2020-03-30 00:00:00+08:00"
tags: [frontend, css]
pull_request_id: 3
---

# CSS 权重和 CSS 模块

> 我的样式怎么被覆盖了？

我们常常在工作中遇到这样的问题，所以介绍一下 CSS 权重，以及用来解决非预期覆盖的隔离方案 CSS 模块以及业界同类方案。

我们有三个写样式的地方，外部样式（`external`）、内部样式（`internal`）和内联样式（`inline`）。内联最高，外部和内部根据先后顺序，后面的覆盖前面的。在 `react`或者`vue`里，当我们使用 `style` 对象时，我们使用的是内联样式，其他会根据编译配置生成外部样式进行引用或内部样式放在 `head` 里。

~~~html
<html>
  <head>
    <!-- internal -->
    <style>
      #box {
        width: 100px;
        height: 100px;
        background-color: red;
        color: yellow;
      }
    </style>
    <!-- external -->
    <link rel="stylesheet" href="style.css" />
    <!-- internal -->
    <style>
      #box {
        background-color: black;
        color: purple;
      }
    </style>
  </head>
  <body>
    <!-- inline -->
    <div id="box" style="color: green">Hello World</div>
  </body>
</html>
~~~

~~~css
// style.css
#box {
  width: 200px;
  background-color: purple;
  color: orange;
}
~~~

对于一个元素 `<div id="my-id" class="my-class" data-my-attr></div>`，定义样式除了使用内联（`inline`）外，可以使用选择器 `ID`（`#my-id`）、类（`.my-class`）、属性（`[data-my-attr]`）、伪类（`:hover`）、元素（`div`）进行定位然后定义。

优先级只需记得，内联最高，`ID` 其次，元素最低，其余同级。两条规则由高到低进行比较，同一级别包含数目多的优先，全部比完相同，则后面定义的覆盖前面的（比如 `.my-class` 比 `body div` 优先，`.my-class[data-my-attr]` 比 `.myclass` 优先）。了解这些已经可以应付工作中 99% 的情况了（可能会有人提到伪元素或者 `not`）。大部分时候我们建议少用或不用内联（不方便统一管理可能遗漏）和 `ID`（不可重复定义）。另外一个是 `!important`，如果有 `!important` 则无视其他规则，如果两个同时有 `!important` 则继续按照其他规则，因此也是建议少用或不用。

### CSS 模块

有了以上规则，实际工作中，我们可能写出 `.app .container .mod ul.list li > div.label` 的选择器去力求我们足够具体，然而不管我们怎么具体，都依然有可能（而且概率还不小）被别人用更具体的选择器覆盖。

CSS 模块，通过类名追加哈希字符串的方式来进行样式隔离。比如在 CSS 定义里使用 `.App` 选择器，最终编译出来的是原本类名加一个哈希字符串 `.App_App__rq8wc`（`react` 还在前面追加文件名），而 html 里则是 `<div class="App_App__rq8wc" />`，这样大概率你不再会和别人定义的样式重名，除非你引用了别人的样式。严格的说，这样依然有极其极其微小的概率发生哈希碰撞导致样式被别人覆盖，那真遇到了这种情况，让我们具体情况具体分析去解决吧。

其他同类方案，比如 `vue` 的 `scoped` 采用的是属性加哈希字符串（`<div data-v-90e5aa2a="" class="App" />`）；`styled-components` 也是类名加哈希字符串（`<div class="styleButton__Swipe-sc-2zuwrv-1 hNMTVl" />`）。顺便说一下，`styled-components` 本质是用 `javascript` 去写 `css`，如同 `jsx` 用 `javascript` 去写 `html` 一样，这样可以使用变量、条件判断去给样式赋值，带来了灵活性，不过如果设计人员也需要有权限改样式或者有样式 monkey patch 的需求，CSS 模块化可以提供更安全的环境。

### 参考文献：

1. [MDN CSS Specificity](https://developer.mozilla.org/en-US/docs/Web/CSS/Specificity)
1. [CSS Specificity Calculator](https://specificity.keegan.st/)
1. [CSS Modules](https://github.com/css-modules/css-modules)
