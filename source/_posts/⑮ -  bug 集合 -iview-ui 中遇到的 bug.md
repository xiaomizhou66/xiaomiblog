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

## 3.2 tag 标签的问题

Tag 标签上面绑定时间不要忘记使用  .native 属性，不然时间没法执行。

```HTML
<template slot-scope="{ row }" slot="state">
  <div v-if="row.shelf">
    <Tag color="primary">已上架</Tag>|
    <Tag @click.native="toUnShelf(row)">下架</Tag>
  </div>
  <div v-else>
    <Tag color="default">已下架</Tag>|
    <Tag @click.native="toShelf(row)">上架</Tag>
  </div>
</template>

<script>
// 商品上架
toShelf(row) {
  row.shelf = true;
  console.log("上架");
  // let updateData = {
  //   shelf: true
  // };
  // this.updateProduct(row.id, updateData);
},
// 商品下架
toUnShelf(row) {
  row.shelf = false;
  // let updateData = {
  //   shelf: false
  // };
  // this.updateProduct(row.id, updateData);
  console.log("下架");
}
</script>
```

## 3.3 table 表格的问题

```HTML
    <Table
      @on-select="selectProduct"              //选中 某一项 时触这个事件
      @on-select-cancel="cancelSelectProduct" //取消 选中 某一项 时触发
      @on-selection-change="selectChange"     //选中 或 取消选中 某一项 时触发
      :border="true"
      ref="selection"
      :columns="productTableColumns"
      :data="productTableData.products"
      stripe
      :loading="pageData.isLoading"
    >XXXXXX</table>
<script>
  selectProduct(selection,row){
    //selection 已选项数据,包括刚刚选择的 row 数据
    //row：刚选择的项数据
  },
  cancelSelectProduct(selection,row){
    //selection 已选项数据,已经去掉了 取消的 row 选项
    //row： 刚 取消 的项数据
  },
  selectChange(selection){
    //selection 已选项数据
    // 选中或者取消选中都会触发这个事件
  }
  on-select-all-cancel//在多选模式下有效，点击取消全选时触发 (就是点击表格左上角的全选 选择框 触发的事件)
  selection//已选项数据
  on-selection-change//在多选模式下有效，只要选中项发生变化时就会触发 (就是点击表格左上角的全选 选择框 触发的事件)
  selection//已选项数据
</script>
```

如果不希望直接勾选表格左上角的按钮来全选，取消全选的话，这样来做

1. 给 table 一个 ref 特性 ref="selection"
2. 代码如下

```HTML
  <Button type="primary" size="large" @click="selectAll(true)">
    <Icon type="icon-SelectAll"/>全选
  </Button>
  <Button type="primary" size="large" @click="selectAll(false)">
    <Icon type="icon-quxiaoquanxuan"/>取消全选
  </Button>
<script>
  // 选择全部
  selectAll(status) {
    this.$refs.selection.selectAll(status);
  },
</script>
```