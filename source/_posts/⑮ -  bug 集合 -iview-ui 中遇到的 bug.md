---
title: iview-ui 使用过程的各种问题 
date: '2018/8/19 23:57:28'
categories:
  - ⑮ bug 集合
  - vue 中遇到的 bug
updated:
tags:
comments:
---

# 一、前言

iview-ui 组件比较丰富，但是使用起来总是会遇到一些问题。

# 二、安装引入的问题

通常我们使用的是 vue-cli3 但是 iview-ui 使用的是 iview 提供的脚手架的引入方法，不能照搬 iview-ui 的方法。

# 三、 menu 的问题

## 3.1 iview 使用 Menu 组件动态生成时 active-name 不起作用

案例中给的是固定的数字，通常我会绑定动态的字符串，但是发现它没有起作用。这个 active-name 还要和另外两个函数配合使用才可以的。

```JS
// 方法名         说明	              参数
updateOpened      //手动更新展开的子目录，注意要在 $nextTick 里调用   没有参数
updateActiveName  //手动更新当前选择项，注意要在 $nextTick 里调用     没有参数
```

```HTML
<!-- 
1、给Menu组件绑定ref ,例如side_menu
2、menu列表更新时，手动更新 -->
<template>
<!-- 侧边栏 -->
  <Sider>
    <!-- 这个 width="auto" 要设置，然后才不会 超出 Sider 的宽 -->
    <Menu
      ref="left_menu"
      theme="dark"
      width="auto"
      :active-name="siderMenuActiveName"
      @on-select="changeMenu"
    >
      <MenuGroup title="运营详情">
        <MenuItem name="overview">
          <i class="iconfont icon-shangpin2"></i> 销售动态
        </MenuItem>
        <MenuItem name="orders">
          <i class="iconfont icon-dingdan1"></i> 订单管理
        </MenuItem>
        <MenuItem name="chargeback">
          <i class="iconfont icon-dingdan1"></i> 退单处理
        </MenuItem>
      </MenuGroup>
      <MenuGroup title="商品设置">
        <MenuItem name="product">
          <i class="iconfont icon-shangpin2"></i> 商品管理
        </MenuItem>
        <MenuItem name="swiper">
          <i class="iconfont icon-shangpin2"></i> 轮播设置
        </MenuItem>
      </MenuGroup>
      <MenuGroup title="物流详情">
        <MenuItem name="logistics">
          <i class="iconfont icon-wuliu-copy"></i> 物流信息
        </MenuItem>
      </MenuGroup>
      <MenuGroup title="用户中心">
        <MenuItem name="users">
          <i class="iconfont icon-yonghu"></i> 用户管理
        </MenuItem>
      </MenuGroup>
    </Menu>
  </Sider>
</template>

<script>
  data() {
    return {
      siderMenuActiveName: "overview"
    };
  },
  mounted() {
    //在 created 和 mounted 阶段，如果需要操作渲染后的试图，也要使用 nextTick 方法。
    this.$nextTick(() => {
      this.$refs.left_menu.updateOpened();
      this.$refs.left_menu.updateActiveName();// 只要不是在 template 中固定写的，
      //在 data 中写的，就是动态的，赋值之后，都是要使用这个方法来更新 active-name 的。
      //updateOpened()，updateActiveName() 还是要求在 this.$nextTick() 中执行，
      // 并且 ref 是在 mounted 才会读取到的，这段代码，必然要在  mounted() 周期写了
      document.querySelector(
        ".layout-title"
      ).innerHTML = document.querySelector(".ivu-menu-item-selected").innerHTML;
    });
  },
  methods: {
    // 侧边栏切换，侧边栏更新，我们 menu 的 name 值是要更新的，还是不要忘记手动的更新 active 值。
    // 这里说的手动更新，（就是用户在点击侧边栏，然后触发事件，代码中的 updateOpened()，updateActiveName()  函数执行去更新 active-name 值！！！！）
    changeMenu(name) {
      this.siderMenuActiveName = name;
      this.$nextTick(() => {
        this.$refs.left_menu.updateOpened();
        this.$refs.left_menu.updateActiveName();
        document.querySelector(
          ".layout-title"
        ).innerHTML = document.querySelector(
          ".ivu-menu-item-selected"
        ).innerHTML;
      });
      this.$router.push(name);
    }
  }
</script>
```