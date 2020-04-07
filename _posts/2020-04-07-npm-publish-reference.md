---
title:  "NPM Publish Reference"
date:   "2020-04-07 00:00:00+08:00"
tags: [frontend, javascript]
pull_request_id: 4
---

> 中文版在英文版之后。

# NPM Publish Reference

Talking over `NPM Publish`, it is unavoidable to go through the long evolution history of `CommonJS` and `AMD` into `UMD` and finally `ES Module`. However, we choose to leave it to further reading in References.

In short, we are supposed to publish `ES Module` stated in `module` field, for those projects able to recognize `ES Module`; for other projects unable to do so, we are supposed to publish `CommonJS` stated in `main`; if we have browser support requirements, we are supposed to publish `UMD` instead of `CommonJS` or side by side.

## Published directories

Here we provide a list of well-known javascript/typescript projects on Github, let's take a look how they publish npm packages:

1. `redux`:
    - adopts `Rollup`;
    - inside repository, places source code under `src` with nothing else published;
    - inside `npm`, publishes:
      - `src`;
      - `lib` (uncompressed `CommonJS`, pointed by `main`);
      - `es` (uncompressed and compressed `ES Module`, pointed by `module`);
      - `dist` (uncompressed and compressed `UMD`, pointed by `unpkg`);
1. `react-use`:
    - adopts `tsc`;
    - inside repository, places source code under `src` with nothing else published;
    - inside `npm`, publishes:
      - `lib` (uncompressed `CommonJS`, pointed by `main`);
      - `esm` (uncompressed `ES Module`, pointed by `module`);
1. `vue`:
    - adopts `Rollup`;
    - inside repository, places source code under `src`, along with `dist` published;
    - inside `npm`, publishes:
      - `src`;
      - `dist` (containing uncompressed and compressed `CommonJS`, uncompressed and compressed `ES Module` and uncompressed and compressed `UMD`), with `main` pointing at `CommonJS`, `module` pointing at `ES Module` and `unpkg` and `jsdelivr` pointing at `UMD`;
1. `react`:
    - adopts `Rollup`;
    - inside repository, places sources code under `src` of MonoRepo, with nothing else published;
    - inside `npm`, publishes:
      - `cjs` (uncompressed and compressed `CommonJS`, pointed by `main`);
      - `umd` (uncompressed and compressed `UMD`);
1. `angular`:
    - adopts internal tools;
    - inside repository, places source code under `src` of MonoRepo, with nothing else published;
    - inside `npm`, publishes:
      - `bundles` (uncompressed and compressed `UMD`, pointed by `main`);
      - various versions of `ES Module` (`esm` vs. `fesm`, `ES5` vs. `ES2015`, `module` pointing at `fesm5`);
1. `react-router`:
    - adopts `Rollup`;
    - inside repository, places source code under `modules` of MonoRepo, with nothing else published;
    - inside `npm`, publishes:
      - `cjs` (uncompressed and compressed `CommonJS`, pointed by `main`);
      - `esm` (uncompressed `ES Module`, pointed by `module`);
      - `umd` (uncompressed and compressed `UMD`);
1. `axios`:
    - adopts `Webpack`;
    - inside repository, places source code under `lib`, along with `dist` published;
    - inside `npm`, publishes:
      - `lib`;
      - `dist` (uncompressed and compressed `UMD`, pointed by `main`);
1. `material-ui`:
    - adopts `Rollup` for `UMD` and `Babel` for `CommonJS` and `ES Module`;
    - inside repository, places source code under `src` of MonoRepo, with nothing else published;
    - inside `npm`, publishes:
      - root directory (uncompressed `CommonJS`, pointed by `main`);
      - `es` (uncompressed `ES Module`);
      - `esm` (uncompressed `ES Module` of `ES5`, pointed by `module`);
      - `umd` (uncompressed and compressed `UMD`);
1. `antd`:
    - adopts `Webpack`;
    - inside repository, places source code under `components`, with nothing else published;
    - inside `npm`, publishes:
      - `lib` (uncompressed `CommonJS`, pointed by `main`);
      - `es` (uncompressed `ES Module`, pointed by `module`);
      - `dist` (uncompressed and compressed `UMD`, pointed by `unpkg`);
1. `element-ui`:
    - adopts `Webpack`;
    - inside repository, places source code under `src` and `packages`, with nothing else published;
    - inside `npm`, publishes:
      - `lib` (single-file and multiple-file `CommonJS`, compressed `UMD`, `main` pointing at `CommonJS`).

`unpkg` links of above mentioned projects can be found in References and `package.json` has field `repository` for repository info.

## Recommendation

1. Adopt `Rollup`, for fast compilation, smaller bundle size and clean and straightforward configuration and workflow;
1. Place source code under `src` or `src` of MonoRepo;
1. Publish `UMD`、`CommonJS` 和 `ES Module` in separate directories, or in directories with common conventions (e.g. `lib` for `CommonJS` and `dist` for `UMD`);
1. Publish both uncompressed and compressed `UMD` (for development and production purpose);
1. Publish both uncompressed and compressed `ES Module` since popular browsers are powerful and smark enough;
1. Point `main` at `CommonJS` or `UMD` and `module` at `ES Module` in `package.json`.

BTW, `typescript` projects will also publish `.d.ts` files, which can benefit target users as well as IDEs a lot. Alternatively, you can write your own type definition files.

# NPM 发布参考

说到 `NPM Publish`，免不了去介绍 `CommonJS` 和 `AMD` 然后到 `UMD` 再到 `ES Module` 的历史，这边把详细介绍放在参考文献里。

简而言之我们需要，发布以 `module` 为入口的 `ES Module` 版本，供能识别 `ES Module` 的项目使用；发布以 `main` 为入口的 `UMD` 版本，供浏览器和不能识别 `ES Module` 的项目使用，如果不需要浏览器支持则可以只发布 `CommonJS` 版本。

## 发布目录

这边先罗列一下大家耳熟能详的一些项目的发布方式：

1. `redux`：
    - 使用 `Rollup`；
    - 仓库里，源代码在 `src`，无其他发布内容；
    - `npm` 里，发布：
      - `src`；
      - `lib`（非压缩的 `CommonJS`，`main`）；
      - `es`（非压缩和压缩的 `ES Module`，`module`）；
      - `dist`（非压缩和压缩的 `UMD`，`unpkg`）；
1. `react-use`：
    - 使用 `tsc`;
    - 仓库里，源代码在 `src`，无其他发布内容；
    - `npm` 里，发布：
      - `lib`（非压缩的 `CommonJS`，`main`）；
      - `esm`（非压缩的 `ES Module`，`module`）；
1. `vue`：
    - 使用 `Rollup`；
    - 仓库里，源代码在 `src`，同时发布 `dist`；
    - `npm` 里，发布：
      - `src`；
      - `dist`（非压缩和压缩的 `CommonJS`、非压缩和压缩的 `ES Module`、非压缩和压缩的 `UMD`），`main` 指向 `CommonJS`，`module` 指向 `ES Module`，`unpkg` 和 `jsdelivr` 指向 `UMD`；
1. `react`：
    - 使用 `Rollup`；
    - 仓库里，源代码在 MonoRepo 的 `src`，无其他发布内容；
    - `npm` 里，发布：
      - `cjs`（非压缩和压缩的 `CommonJS`，`main`）；
      - `umd`（非压缩和压缩的 `UMD`）；
1. `angular`：
    - 使用内部工具；
    - 仓库里，源代码在 MonoRepo 的 `src`，无其他发布内容；
    - `npm` 里，发布：
      - `bundles`（非压缩和压缩的 `UMD`，`main`）；
      - 多种 `ES Module`（`esm` 和 `fesm`，`ES5` 和 `ES2015`，`module` 指向 `fesm5`）；
1. `react-router`：
    - 使用 `Rollup`；
    - 仓库里，源代码在 MonoRepo 的 `modules`，无其他发布内容；
    - `npm` 里，发布：
      - `cjs`（非压缩和压缩的 `CommonJS`，`main`）；
      - `esm`（非压缩的 `ES Module`，`module`）；
      - `umd`（非压缩和压缩的 `UMD`）；
1. `axios`：
    - 使用 `Webpack`；
    - 仓库里，源代码在 `lib`，同时发布 `dist`；
    - `npm` 里，发布：
      - `lib`；
      - `dist`（非压缩和压缩的 `UMD`，`main`）；
1. `material-ui`：
    - 使用 `Rollup` 生成 `UMD` 和 `Babel` 生成 `CommonJS` 和 `ES Module`；
    - 仓库里，源代码在 MonoRepo 的 `src`，无其他发布内容；
    - `npm` 里，发布：
      - 扁平目录（非压缩的 `CommonJS`，`main`）；
      - `es`（非压缩的 `ES Module`）；
      - `esm`（非压缩的 `ES5` 的 `ES Module`，`module`）；
      - `umd`（非压缩和压缩的 `UMD`）；
1. `antd`：
    - 使用 `Webpack`；
    - 仓库里，源代码在 `components`，无其他发布内容；
    - `npm` 里，发布：
      - `lib`（非压缩的 `CommonJS`，`main`）；
      - `es`（非压缩的 `ES Module`，`module`）；
      - `dist`（非压缩和压缩的 `UMD`，`unpkg`）；
1. `element-ui`：
    - 使用 `Webpack`；
    - 仓库里，源代码在 `src` 和 `packages`，无其他发布内容；
    - `npm` 里，发布：
      - `lib`（整合和散装的非压缩的 `CommonJS`、压缩的 `UMD`），`main` 指向 `CommonJS`。

以上项目都能在参考文献里找到 `unpkg` 的链接，然后在 `package.json` 里找到仓库。

## 推荐方案

1. 使用 `Rollup`，使得你的编译打包更快、体积更小（可以阅读参考文献），编译配置及流程清晰（一些项目整个流程非常繁冗复杂）；
1. 源代码放在 `src` 或者 MonoRepo 的 `src`；
1. 单独为 `UMD`、`CommonJS` 和 `ES Module` 建立发布目录，或者使用有习惯用途的目录命名（`CommonJS` 放在 `lib`，`UMD` 放在 `dist`）；
1. `UMD` 提供非压缩和压缩两个版本（供开发和生产使用）；
1. `ES Module` 最好也提供压缩版本，供浏览器使用；
1. `package.json` 的 `main` 指向 `CommonJS` 或 `UMD`， `module` 指向 `ES Module`。

另外说一下，`typescript` 的项目会发布 `.d.ts` 的文件，可以给 IDE 以及开发者提供便利。不过也可以自行编写类型定义文件。

References:

1. NPM official documentation: [packages-and-modules](https://docs.npmjs.com/about-packages-and-modules), [npm-package](https://docs.npmjs.com/files/package.json#main)
1. [JavaScript module system](https://www.freecodecamp.org/news/anatomy-of-js-module-systems-and-building-libraries-fadcd8dbd0e/), [CommonJS](http://wiki.commonjs.org/wiki/Modules/1.1.1), [Asynchronous Module Definition](https://requirejs.org/docs/whyamd.html), [IIFE](https://developer.mozilla.org/en-US/docs/Glossary/IIFE)
1. Popular repositories: [redux](https://unpkg.com/browse/redux@4.0.5/), [react-use](https://unpkg.com/browse/react-use@14.0.0/), [vue](https://unpkg.com/browse/vue@2.6.11/), [react](https://unpkg.com/browse/react@16.13.1/), [angular](https://unpkg.com/browse/@angular/core@9.1.0/), [react-router](https://unpkg.com/browse/react-router@5.1.2/), [axios](https://unpkg.com/browse/axios@0.19.2/), [material-ui](https://unpkg.com/browse/@material-ui/core@4.9.9/), [antd](https://unpkg.com/browse/antd@4.1.1/), [element-ui](https://unpkg.com/browse/element-ui@2.13.0/)
1. [Angular Flattening of ES Modules](https://github.com/ng-packagr/ng-packagr#knowledge)
1. [The cost of small modules](https://nolanlawson.com/2016/08/15/the-cost-of-small-modules/) (Rollup recommendation)
