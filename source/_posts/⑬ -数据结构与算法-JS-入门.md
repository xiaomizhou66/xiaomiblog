---
title: 'JavaScript 数据结构与算法【1】--[入门版]'
date: '2018/8/19 23:57:28'
categories:
  - ⑬ 数据结构与算法
updated:
tags:
comments:
---

## 一、 前言

学习数据结构与算法是每一个前端与后端设计人员必需的。学会数据结构将会拓展我们的思维，让我们拥有有效的解决业务需求的能力。

名称是 **数据结构与算法** 那么我们需要学习的就是一些 **数据结构** 以及 **算法** 

## 二、 JavaScript 以及 ES6

关于 JavaScript 的基本知识 以及 ES6语法的学习。网址：

## 三、 数据结构

### 3.1 数组 Array

数组是编程语言的内建类型，通常效率很高，可以满足不同需求的数据存储。

#### 3.1.1 数组的标准定义

数组的标准定义：一个存储元素的 **线性集合**，元素可以通过 **索引** 任意存储数据。索引通常是数字，用来计算元素之间的存储位置的偏移量。

JavaScript 中的数组与其他语言不同， **JavaScript 中的数组是一种特殊的对象** ，用来表示偏移量的 **索引** 是该对象的 **属性**。
索引可能是整数，但是这些 **数字索引在内部被转换为字符串类型** ，因为 **JavaScript 对象中的属性必须是字符串** 。

由于 JavaScript 中的数组只是一种特殊的对象，所以效率上不如其他的语言中的数组高。JavaScript 中的数组，严格来说应该被称为对象，是 JavaScript 中的特殊对象，在内部被归类为数组。数组的长度可以任意的增长，超出其创建时指定的长度。length 属性指的是当前数组中元素的个数。

由于 Array 在 JavaScript 中被当作对象，因此它有许多属性和方法可以在编程时使用。

#### 3.1.2 数组的创建 [] new Array()

```JS
var arr=[]          //  通过操作符[]来创建
var arr=[1,2,3,4,5] //  通过操作符创建并且初始化元素
var arr=new Array() //  通过构造函数创建
var arr=new Array(1,2,3,4,5) //  通过构造函数创建并且初始化元素
var arr=new Array(137) //  通过构造函数创建并且初始化长度 （只传入一个参数就作为数组的长度）

// 使用操作符 [] 来初始化更为高效
```

#### 3.1.3 数组的属性 Array.length 

length 是 Array 的实例属性。返回或设置一个数组中的元素个数。该值是一个无符号 32-bit 整数，并且总是大于数组最高项的下标。

#### 3.1.4 数组的属性 Array.prototype

表示 Array 构造函数的原型，并允许您向所有Array对象添加新的属性和方法。Array.prototype 本身也是一个 Array ， `Array.isArray(Array.prototype); // true`

```JS
/*
  如果JavaScript本身不提供 first() 方法，
  添加一个返回数组的第一个元素的新方法。
*/

if(!Array.prototype.first) {
  Array.prototype.first = function() {
    console.log(`如果JavaScript本身不提供 first() 方法，添加一个返回数组的第一个元素的新方法。`);
    return this[0];
  }
}
```

#### 3.1.5 Array.from() 方法

从一个类似数组或可迭代对象中创建一个新的数组实例。

```JS
console.log(Array.from('foo'));
// expected output: Array ["f", "o", "o"]

console.log(Array.from([1, 2, 3], x => x + x));
// expected output: Array [2, 4, 6]
```

#### 3.1.6 Array.isArray() 方法

用于确定传递的值是否是一个 Array。当检测Array实例时, Array.isArray 优于 instanceof,因为Array.isArray能检测iframes.

```JS
//方法的创建
if (!Array.isArray) {
  Array.isArray = function(arg) {
    return Object.prototype.toString.call(arg) === '[object Array]';
  };
}
```

```JS
Array.isArray([1, 2, 3]);  // true
Array.isArray({foo: 123}); // false
Array.isArray("foobar");   // false
Array.isArray([]); // true
Array.isArray([1]); // true
Array.isArray(new Array());// true
Array.isArray(Array.prototype);// true     Array.prototype 也是一个数组。它的 length 为 0
Array.isArray();  // false
Array.isArray({});  // false
Array.isArray(null);  // false
Array.isArray(undefined);  // false
Array.isArray(17);  // false
Array.isArray('Array');  // false
Array.isArray(true);  // false
Array.isArray(false);  // false
Array.isArray({ __proto__: Array.prototype });  // false
```

#### 3.1.3 字符串与数组之间的转化 str.split() Array.toString() Array.json()

```JS
var sentance = 'I am what i am !'
var arr=sentance.split(' ') // 以字符串中的某个字符来切分字符串，返回一个数组
var str=arr.toString() //不需要传参，得到字符串是数组中每项以逗号连接
var str2=arr.json()    //如果没有传参，得到字符串是数组中每项以逗号连接
var str3=arr.json('')    //传入参数作为连接符号
var str4=arr.json(' ')    //传入参数作为连接符号

// arr=['I','am','what','i','am','!']
// str='I,am,what,i,am,!'
// str2='I,am,what,i,am,!'
// str3='Iamwhatiam!'
// str4='I am what i am !'
```

#### 3.1.4 查找元素 indexOf() 与 lastIndexOf()

```JS
var  arr=['xiaomi','liu','liuxiaomi','liuliuliu','liu']
arr.indexOf('liu') // 1   从前往后查找第一个
arr.lastIndexOf('liu') // 4  从后往前查找第一个
arr.indexOf('mei') // -1   找不到的话就返回 -1
```

#### 3.1.5 已知数组得到新数组 Array.contact(array,item1,item2...) splice(index,n,item1,item2...)

**Array.contact(array,item1,item2...)**

```JS
var arr = ["Mike", "Clayton", "Terrill", "Danny", "Jennifer"]
var arr2 = ["Raymond", "Cynthia", "Bryan"]
var newArr = arr.concat(arr2)
console.log(arr) //"Mike,Clayton,Terrill,Danny,Jennifer"   就是原数组不会被改变
console.log(newArr) //"Mike,Clayton,Terrill,Danny,Jennifer,Raymond,Cynthia,Bryan" 得到的新数组

var newArr2 =arr.concat('xiaomi',2) //可以连接数组用可以直接连接项
console.log(newArr2) //Mike,Clayton,Terrill,Danny,Jennifer,xiaomi,2
```

**splice(index,n,item1,item2...)**   原数组会被改变

```JS
var arr = ["Mike", "Clayton", "Terrill", "Danny", "Jennifer"]
var newArr = arr.slice(1)

var newArr2 = arr.splice(1) // 表示从索引为 1 删除到最后一个
console.log(arr) //  Mike  原数组被改变了
console.log(newArr2) // Clayton,Terrill,Danny,Jennifer  得到的新数组（为被删除的项组成）

var newArr3 = newArr2.splice(1,1,'xiaomi','zihua') //
console.log(newArr2) //  Clayton,xiaomi,zihua,Danny,Jennifer   第二项被删除了然后加入两项
console.log(newArr3) //   Terrill  得到的新数组是被删除的项组成的

//该函数方法与有 3 以上 个参数，开始索引 删除的长度/元素个数  后面的是添加的项 
arr.splice(start);  // [start, end]  只有一个参数表示，从该下标删除到后面一个
arr.slice(begin);  // [start, count]   只有 2 个参数，表示从 start 处 删除 count 个元素
arr.slice(begin, end); // [start,count,item1,item2...]  表示从 start 处 删除 count 个元素，并且插入元素 item1,item2...
```

**slice(start，end)**     原数组不会改变，只是获取数组切片

```JS
var arr = ["Mike", "Clayton", "Terrill", "Danny", "Jennifer"]
console.log(arr) //  Mike,Clayton,Terrill,Danny,Jennifer  就是原数组不会被改变
console.log(newArr) // Clayton,Terrill,Danny,Jennifer  得到的新数组

//该函数方法与有两个参数，开始索引与结束索引
arr.slice();  // [0, end]  没有参数表示获取数组的全部元素
arr.slice(begin);  // [start, end]   只有一个参数，参数表示开始索引 取到最后一项，包括最后一项
arr.slice(begin, end); // [start, end)  两个参数，表示开始索引 取到最后一项，但是不包括最后一项，为半闭区间
```

### 3.2 列表

#### 3.2.1 列表的定义

**列表是一组有序的数据**。每个列表中的数据项称为元素。在 JavaScript 中，列表中的元素可以是任意数据类型。列表中可以保存多少元素并没有事先限定，实际使用时元素的数量受到程序内存的限制。

#### 3.2.2 列表的应用场景

待办事项列表、购物清单、十佳榜单、最后十名榜单等

#### 3.2.3 列表的属性与方法

#### 3.2.3 列表的创建

### 3.3 栈

#### 3.3.1 栈的定义

#### 3.3.2 栈的应用场景

#### 3.3.3 栈的属性与方法

#### 3.3.3 栈的创建

### 3.4 队列

#### 3.4.1 队列的定义
#### 3.4.2 队列的应用场景
#### 3.4.3 队列的属性与方法
#### 3.4.3 队列的创建

### 3.5 链表

#### 3.5.1 链表的定义
#### 3.5.2 链表的应用场景
#### 3.5.3 链表的属性与方法
#### 3.5.3 链表的创建

### 3.6 字典

#### 3.6.1 字典的定义
#### 3.6.2 字典的应用场景
#### 3.6.3 字典的属性与方法
#### 3.6.3 字典的创建

### 3.7 散列

#### 3.7.1 散列的定义
#### 3.7.2 散列的应用场景
#### 3.7.3 散列的属性与方法
#### 3.7.3 散列的创建

### 3.8 集合 Set

#### 3.8.1 集合的定义
#### 3.8.2 集合的应用场景
#### 3.8.3 集合的属性与方法
#### 3.8.3 集合的创建

### 3.9 树

#### 3.9.1 树的定义 、二叉查找树的定义

**树的定义**
树由一组以边连接的节点组成。公司的组织结构图就是一个树的例子。
树是一种非线性的数据结构，**以分层的方式存储数据**。树被用来 **存储具有层级关系的数据**，比如 **文件系统中的文件**；树还被用来存储 **有序列表**。

- 根节点：一棵树最上面的节点称为根节点
- 父节点：如果一个节点下面连接多个节点，那么该节点称为父节点
- 子节点：父节点下面的节点称为子节点，一个节点可以有 0 个、1 个或多个子节点。
- 叶子节点：没有任何子节点的节点称为叶子节点。
- 路径：从一个节点到另一个节点的这一组边称为路径
- 边：两点之间连线为边，（边构成路径）
- 树的遍历：在图中用虚线表示。以某种特定顺序访问树中所有的节点称为树的遍历。
- 层次：树可以分为几个层次，根节点是第 0 层，它的子节点是第 1 层，子节点的子节点是第 2 层，以此类推。
- 宽度：（二叉查找树中）具有最多结点数的层中包含的结点数。
- 深度：我们定义树的层数就是树的深度，数有多少层，深度就是多少
- 左子树：根节点的左子节点以及延伸的子节点
- 右子树：根节点的右子节点以及延伸的子节点
- 左节点：（二叉查找树中）一个父节点的左边子节点
- 右节点：（二叉查找树中）一个父节点的右边子节点
- 树中任何一层的节点可以都看做是子树的根，该子树包含根节点的子节点，子节点的子节点等
- 键：每个节点都有一个与之相关的值，该值有时被称为键。

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181023223112.png)

**二叉查找树的定义** （英语：Binary Search Tree）
二叉树是一种特殊的树，它的子节点个数不超过两个,左节点比父节点小，右节点比父节点大.二叉树非常适合于范围查找， 查找树的定义非常简单.，还有一个特性就是'中序遍历'可以让结点有序。可以写出高效的程序在树中插入、查找和删除数据。二叉查找树是一种特殊的二叉树，相对较小的值保存在左节点中，较大的值保存在右节点中。这一特性使得查找的效率很高，对于数值型和非数值型的数据，比如单词和字符串，都是如此。

![TU](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181023224013.png)

#### 3.9.2 树的属性与方法

```JS
//二叉树节点类 BSTNode
function BSTNode(data,left, right) {
  this.data = data; //保存数据
  this.count = 1 //保存数据出现的次数，记录相同数据出现的次数(这个属性需要的话就写，不需要的话不写，初始化为 1 )
  this.left = left; //保存左节点链接
  this.right = right; //保存右节点链接
  this.show = function show() { //显示保存在节点中的数据。
    return this.data;
  }
}

// BST 二叉查找树
function BST() {
  this.rootNode = null //将 BST 类的根节点定义为 null 空节点 

  this.insert = function insert(data) { // 插入数据
    let newNode = new Node(data, null, null) //传参 data 构造待插入节点
    if (this.rootNode == null) {
      this.rootNode = newNode // 如果根节点为空，插入的节点赋值给根节点
    } else {
      let currentNode = this.rootNode // 定义当前节点为根节点 开始循环遍历树
      let parentNode //一定要弄个中间变量
      while (true) {
        parentNode = currentNode //将当前节点保存为父节点
        if (data < currentNode.data) {
          currentNode = currentNode.left
          if (currentNode == null) { //如果当前左节点为 空节点 那就让将插入的新节点赋值给父节点的左子节点
            parentNode.left = newNode
            break
          }
        } else {
          currentNode = currentNode.right
          if (currentNode == null) {
            parentNode.right = newNode
            break
          }
        }
      }
    }
  }

  // 前后中 就是看根节点的顺序了，左一直在右的前面就对了！！！！
  // 中序：那么就是根节点在中间 也就是 左-根-右
  this.inOder = function inOder(node) {
    if (!(node == null)) {
      arguments.callee(node.left)
      putstr(node.show() + ' ') //后续其他的功能只要在这里更新这个语句就好了
      arguments.callee(node.right)
    }
  }
  // 前序/先序：那么就是根节点在先/前 也就是 根-左-右
  this.prevOder = function prevOder(node) {
    if (!(node == null)) {
      putstr(node.show() + ' ') //后续其他的功能只要在这里更新这个语句就好了
      arguments.callee(node.left)
      arguments.callee(node.right)
    }
  }
  // 后序：那么就是根节点在后 也就是 左-右-根
  this.postOder = function postOder(node) {
    if (!(node == null)) {
      arguments.callee(node.left)
      arguments.callee(node.right)
      putstr(node.show() + ' ') //后续其他的功能只要在这里更新这个语句就好了
    }
  }

  //最大值一定是在 右节点的最后一个
  this.getMax = function getMax() {
    let currentNode = this.rootNode
    while (currentNode.right != null) {
      currentNode = currentNode.right
    }
    return currentNode.data //返回当前节点的数据
  }

  //最小值一定是在 左节点的最后一个
  this.getMin = function getMin() {
    let currentNode = this.rootNode
    while (currentNode.left != null) {
      currentNode = currentNode.left
    }
    return currentNode.data
  }

  //查找给定值，返回它的节点，若不存在返回 null
  this.findData = function findData(data) {
    let currentNode = this.rootNode
    while (currentNode != null) {
      if (data = currentNode.data) {
        return currentNode //相等，返回当前节点，结束循环
      } else if (data > currentNode.data) {
        currentNode = currentNode.right // 赋值右节点 进入下一个循环
      } else {
        currentNode = currentNode.left // 赋值左节点 进入下一个循环
      }
    }
    return null //上面的循环没有找到值，没有 return 没有找到值就会执行到这条语句返回一个 null 
  }

  this.removeNode = function removeNode(data) {
    // 这个不知道怎么做，书上的是错误的，？？？？？？？？？？？？？？
  }
  this.removeData = function removeData() {
    // 这个不知道怎么做，书上的是错误的，？？？？？？？？？？？？？？？
  }

  //用于更新节点中的 count ,并返回修改之后的 节点
  this.update = function update(data) {
    let dataNode = this.findData(data)
    dataNode.count++
    return dataNode
  }

  // 递归方法：求数结构中节点的个数 ,最初传入的参数为根节点
  this.getNodeCount = function getNodeCount(node) {
    if (node == null) {
      return 0
    }
    //根节点不为空，返回 左子树递归 + 右子树递归 + 根节点
    //递归到叶子节点之后就是 0 + 0 + 1,啦
    return arguments.callee(node.left) + arguments.callee(node.right) + 1
  }

  // 遍历方法：可以用遍历方法来计算节点数么
  // 需要传入一个 a={count:0} 变量，传进来的不能只是 count=0
  // 值传递不会改变原值，引用传递可以改变原值，这样原来的 count 属性才会被改变，这个方法比上面的递归麻烦多了！！！
/*   this.getNodeCount = function getNodeCount(node, a) {
    if (!(node == null)) {
      arguments.callee(node.left, a)
      a.count = a.count + 1
      arguments.callee(node.right, a)
    }
  } */

  // 递归方法：求数结构中边的个数
  this.getSideCount = function getSideCount(node) {
    if (node == null) {
      return 0
    }
    // 中间变量 t
    var t =0
    if(node.left !=null) t++ // 左子节点存在那么 边 +1
    if(node.right !=null) t++ // 右子节点存在那么 边 +1
    // 最后返回的是  左子树边 +  右子树边 + 该节点的边 t
    return arguments.callee(node.left) + arguments.callee(node.right) + t
  }
}


// 调用 二叉树类 处理数据
var bst1 = new BST()
bst1.insert(23)
bst1.insert(45)
bst1.insert(16)
bst1.insert(37)
bst1.insert(3)
bst1.insert(99)
bst1.insert(22)
bst1.inOder(bst1.rootNode)
//bst1.prevOder(bst1.rootNode)
//console.log(bst1.getNodeCount(bst1.rootNode)) //7  直接调用的是递归函数

/* var a = {count: 0}  //这个方法看出来是没有直接递归的好用的
bst1.getNodeCount(bst1.rootNode, a)
console.log(a.count) //7 */
```

##### 3.9.2.1 求二叉树第K层的节点个数

递归解法：
（1）如果二叉树为空或者k<1返回0
（2）如果二叉树不为空并且k==1，返回1
（3）如果二叉树不为空且k>1，返回左子树中k-1层的节点个数与右子树k-1层节点个数之和
参考代码如下：

```JS
int GetNodeNumKthLevel(BinaryTreeNode * pRoot, int k)
{
  if(pRoot == NULL || k < 1)
    return 0;
  if(k == 1)
    return 1;
  int numLeft = GetNodeNumKthLevel(pRoot->m_pLeft, k-1); // 左子树中k-1层的节点个数
  int numRight = GetNodeNumKthLevel(pRoot->m_pRight, k-1); // 右子树中k-1层的节点个数
  return (numLeft + numRight);
```

##### 3.9.2.2 求二叉树中叶子节点的个数

递归解法：
（1）如果二叉树为空，返回0
（2）如果二叉树不为空且左右子树为空，返回1
（3）如果二叉树不为空，且左右子树不同时为空，返回左子树中叶子节点个数加上右子树中叶子节点个数
参考代码如下：

```JS
int GetLeafNodeNum(BinaryTreeNode * pRoot)
{
  if(pRoot == NULL)
    return 0;
  if(pRoot->m_pLeft == NULL && pRoot->m_pRight == NULL)
    return 1;
  int numLeft = GetLeafNodeNum(pRoot->m_pLeft); // 左子树中叶节点的个数
  int numRight = GetLeafNodeNum(pRoot->m_pRight); // 右子树中叶节点的个数
  return (numLeft + numRight);
}
```

https://blog.csdn.net/luckyxiaoqiang/article/details/7518888#topic6

#### 3.9.3 树的应用场景

##### 3.9.3.1 二叉查找树：查找速度的应用/树的查找是很快的

后台给的 tree 数据怎么渲染到 tree 组件里？
一般来说后端是不会给这个复杂的结构数据的，只会给简单的，数组，对象数组，这些简单的数据结构类型数据。有时候还是会存在复杂的数据结构的。

##### 3.9.3.2 二叉查找树：（计数）记录考试成绩的分布

BST 二叉查找树：记录一组数据集中数据出现的次数：例如记录考试成绩的分布

```JS
function Node(data, left, right) {
  this.data = data; //保存数据
  this.count = 1 //保存数据出现的次数，记录相同数据出现的次数
  this.left = left; //保存左节点链接
  this.right = right; //保存右节点链接
  this.show = function show() { //显示保存在节点中的数据。
    return this.data;
  }
}

// BST 二叉查找树
function BST() {
  this.rootNode = null //将 BST 类的根节点定义为 null 空节点 

  this.insert = function insert(data) { // 插入数据
    let newNode = new Node(data, null, null) //传参 data 构造待插入节点
    if (this.rootNode == null) {
      this.rootNode = newNode // 如果根节点为空，插入的节点赋值给根节点
    } else {
      let currentNode = this.rootNode // 定义当前节点为根节点 开始循环遍历树
      let parentNode //一定要弄个中间变量
      while (true) {
        parentNode = currentNode //将当前节点保存为父节点
        if (data < currentNode.data) {
          currentNode = currentNode.left
          if (currentNode == null) { //如果当前左节点为 空节点 那就让将插入的新节点赋值给父节点的左子节点
            parentNode.left = newNode
            break
          }
        } else {
          currentNode = currentNode.right
          if (currentNode == null) {
            parentNode.right = newNode
            break
          }
        }
      }
    }
  }

  // 前后中 就是看根节点的顺序了，左一直在右的前面就对了！！！！
  // 中序：那么就是根节点在中间 也就是 左-根-右
  this.inOder = function inOder(node) {
    if (!(node == null)) {
      arguments.callee(node.left)
      putstr(node.show() + ' ') //后续其他的功能只要在这里更新这个语句就好了
      arguments.callee(node.right)
    }
  }
  // 前序/先序：那么就是根节点在先/前 也就是 根-左-右
  this.prevOder = function prevOder(node) {
    if (!(node == null)) {
      putstr(node.show() + ' ') //后续其他的功能只要在这里更新这个语句就好了
      arguments.callee(node.left)
      arguments.callee(node.right)
    }
  }
  // 后序：那么就是根节点在后 也就是 左-右-根
  this.postOder = function postOder(node) {
    if (!(node == null)) {
      arguments.callee(node.left)
      arguments.callee(node.right)
      putstr(node.show() + ' ') //后续其他的功能只要在这里更新这个语句就好了
    }
  }

  //最大值一定是在 右节点的最后一个
  this.getMax = function getMax() {
    let currentNode = this.rootNode
    while (currentNode.right != null) {
      currentNode = currentNode.right
    }
    return currentNode.data //返回当前节点的数据
  }

  //最小值一定是在 左节点的最后一个
  this.getMin = function getMin() {
    let currentNode = this.rootNode
    while (currentNode.left != null) {
      currentNode = currentNode.left
    }
    return currentNode.data
  }

  //查找给定值，返回它的节点，若不存在返回 null
  this.findData = function findData(data) {
    let currentNode = this.rootNode
    while (currentNode != null) {
      if (data == currentNode.data) {
        return currentNode //相等，返回当前节点，结束循环
      } else if (data > currentNode.data) {
        currentNode = currentNode.right // 赋值右节点 进入下一个循环
      } else {
        currentNode = currentNode.left // 赋值左节点 进入下一个循环
      }
    }
    return null //上面的循环没有找到值，没有 return 没有找到值就会执行到这条语句返回一个 null 
  }

  /*   this.removeNode = function removeNode(data) {
      if (this.findData(data) != null) {

      }
    }
    this.removeData = function removeData() {

    } */

  //用于更新节点中的 count ,并返回修改之后的 节点
  this.update = function update(data) {
    let dataNode = this.findData(data)
    dataNode.count++
    return dataNode
  }

  // 递归方法：求数结构中节点的个数 ,最初传入的参数为根节点
  this.getNodeCount = function getNodeCount(node) {
    if (node == null) {
      return 0
    }
    //根节点不为空，返回 左子树递归 + 右子树递归 + 根节点
    //递归到叶子节点之后就是 0 + 0 + 1,啦
    return arguments.callee(node.left) + arguments.callee(node.right) + 1
  }

  // 遍历方法：可以用遍历方法来计算节点数么 
  // 需要传入一个 a={count:0} 变量，传进来的不能只是 count=0
  // 值传递不会改变原值，引用传递可以改变原值，这样原来的 count 属性才会被改变，这个方法很麻烦，不要用这个方法
/*   this.getNodeCount = function getNodeCount(node, a) {
    if (!(node == null)) {
      arguments.callee(node.left, a)
      a.count = a.count + 1
      arguments.callee(node.right, a)
    }
  } */

  // 递归方法：求数结构中边的个数
  this.getSideCount = function getSideCount(node) {
    if (node == null) {
      return 0
    }
    // 中间变量 t
    var t = 0
    if (node.left != null) t++ // 左子节点存在那么 边 +1
    if (node.right != null) t++ // 右子节点存在那么 边 +1
    // 最后返回的是  左子树边 +  右子树边 + 该节点的边 t
    return arguments.callee(node.left) + arguments.callee(node.right) + t
  }
}

var grades = [88, 90, 100, 90, 99, 81, 90, 56, 34, 66, 77, 55, 77, 88, 55, 44, 22, 66, 99, 78, 98, 90, 56, 34, 23, 53, 64, 47, 87]
var gradesBST = new BST()

// 将分数数组加入到 BST 中，如果已经存在就更新节点 ，不存在就插入节点
for (let grade of grades) {
  if (gradesBST.findData(grade) == null) {
    gradesBST.insert(grade)
  } else {
    gradesBST.update(grade)
  }
}

//输出显示当前拥有的分数:调用任意一个遍历来输出
gradesBST.inOder(gradesBST.rootNode) //怎么只是输出 88 跟节点呢？

// 键盘输入分数检验分数出现的次数
var cont = 'yes'
while (cont == 'yes') {
  putstr('\n please enter a grade:') //提示键盘输入分数
  let grade = parseInt(readline()) //读取键盘输入的数据转化为 整数复制给 grade
  if (gradesBST.findData(grade) == null) {
    console.log('No occurrences of ' + grade)
  } else {
    console.log('Occurrences of ' + grade + ':' + gradesBST.findData(grade).count)
  }
}
```

##### 3.9.3.3 二叉查找树：（计数）记录一段文本中各个单词出现的次数

BST 二叉查找树：记录一组数据集中数据出现的次数：例如一段文本中各个词出现的次数

### 3.10 图

#### 3.10.1 图的定义

图由 **边的集合** 及 **顶点的集合** 组成。图是一种复杂的 **非线性结构**。而在图形结构中，节点之间的关系是任意的，图中任意两个数据元素之间都有可能相关。图G由两个集合V(顶点Vertex)和E(边Edge)组成，定义为G=(V，E)

例如：**地图** 每两个城镇都由某种道路相连。地图，就是一种图，上面的每个 **城镇**可以看作一个 **顶点**，连接城镇的 **道路便是边**。

- 顶点：v1 和 v2 分别是图中的两个顶点，
- 边：**顶点对(v1,v2)**  表示边。简单就是两点之间的连线是边
- 权重：顶点也有权重，也称为成本。
- 有向图：**顶点对**是有序的，如果一个图的顶点对是有序的，则可以称之为有向图，有向图表明了顶点的流向
- 流向：在对有向图中的顶点对排序后，便可以在两个顶点之间绘制一个箭头。有向图表明了顶点的流向。
- 无向图：如果图是无序的，则称之为无序图，或无向图当然也就没有 **流向**了。
- 路径：一个顶点到另一个顶点经过的边集合。图中的一系列顶点构成路径,
- 路径长度，是指一条路径上经过的边的数量，用路径中第一个顶点到最后一个顶点之间边的数量表示
- 回路/环：指一条路径的起点和终点为同一个顶点。由指向自身的顶点组成的路径称, 环的长度为0
- 图: 图由边的集合及顶点的集合组成
- 圈: 是至少有一条边的路径，且路径的第一个顶点和最后一个顶点相同
- 简单圈: 无论是有向图还是 无向图，只要是没有重复边或重复顶点的圈
- 平凡圈: 除了第一个和最后一个顶点以外（区别于环），路径的其他顶点有重复的圈
- 如果两个顶点之间有路径，那么这两个顶点就是强连通的，反之亦然。如果有向图的所有 的顶点都是强连通的，那么这个有向图也是强连通的

#### 3.10.2 图的应用场景

用图对现实中的系统建模比如对交通流量建模，顶点可以表示街道的十字路口，边表示街道。加权的边可以表示限速或者车道的数量。建模人员可以用这个系统来判断最佳路线及最有可能堵车的街道。

任何运输系统都可以用图来建模。比如，航空公司可以用图来为其飞行系统建模。将每个机场看成顶点，将经过两个顶点的每条航线看作一条边。加权的边可以看作从一个机场到另一个机场的航班成本，或两个机场之间的距离，这取决与建模的对象是什么。

包含局域网和广域网（如互联网）在内的计算机网络，同样经常用图来建模。

另一个可以用图来建模的实现系统是消费市场，顶点可以用来表示供应商和消费者。

#### 3.10.3 图的属性与方法
#### 3.10.3 图的创建

## 四、 算法

### 4.1 图算法

见第 3.10 节

### 4.2 排序算法

#### 4.2.1 简单排序

##### 4.2.1.1 冒泡排序（简单排序）

冒泡排序原理：
数组中有 n 个数，比较每相邻两个数，如果前者大于后者，就把两个数交换位置；
第一轮就可以选出一个最大的数放在最后面；下一轮不需要比较它了
第二轮第二大的数字就会在倒数第二个位置;下一轮也不需要比较它了
.........
也就是说那么经过 n-1（数组的 length - 1） 轮，就可以完成所有数的排序。

**外层用来递增排序轮次（总需要比较 n-1 轮），内层循环用来比较替换位置，将本轮最大的数字放到最后**

```JS
// 冒泡排序
function bubbleSort(arr) {
  let n = arr.length
  for (let i = 0; i < n - 1; i++) {
    // 内层循环用来比较：每轮比较之后最后一个数字肯定是最大的数
    // 每轮循环都不需要比较最后一项，因此 j < (n - 1 - i)  ，每轮少比较后面 i  个元素
    for (let j = 0; j < (n - 1 - i); j++) {
      if (arr[j] > arr[j + 1]) {
        //swap(arr, j, j+1) 这里可以在外面写一个交换位置函数
        let t = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = t
      }
    }
    console.log(arr.toString()); // 将每轮的结果输出，需要观察的时候写上这句代码
  }
}
var nums = [10, 8, 3, 2, 2, 4, 9, 5, 4, 3]
bubbleSort(nums)
/* 结果
λ js eg-chapter12.1.js
8,3,2,2,4,9,5,4,3,10
3,2,2,4,8,5,4,3,9,10
2,2,3,4,5,4,3,8,9,10
2,2,3,4,4,3,5,8,9,10
2,2,3,4,3,4,5,8,9,10
2,2,3,3,4,4,5,8,9,10
2,2,3,3,4,4,5,8,9,10
2,2,3,3,4,4,5,8,9,10
2,2,3,3,4,4,5,8,9,10
*/

// 数组元素交换函数
function swap(arr, index1, index2) {
  let t = arr[index1]
  arr[index1] = arr[index2]
  arr[index2] = t
}
```

##### 4.2.1.2 选择排序（简单排序）

选择排序原理：
数组中有 n 个数，选择数组中最小值放到前面
第一轮就可以选出一个最小的数放在最第 0 索引；下一轮不需要管他了
第二轮第二小的数字就会在第 1 索引;下一轮也不需要比较它了
.........
也就是说那么经过 n-1（数组的 length - 1） 轮，就可以完成所有数的排序。

找到数组最小的元素，将它和数组红第一个元素交换位置，接下来，在剩下的元素中找到最小的元素，将它与数组的第二个元素交换位置，往复如此，直到将整个数组排序。基本点就是不断地选择剩余元素之中的最小者。

```JS
function swap(arr, index1, index2) {
  let t = arr[index1]
  arr[index1] = arr[index2]
  arr[index2] = t
}


// 选择排序
function selectSort(arr) {
  let n = arr.length
  // 循环比较 n-1 次就可以完成排序，外层用来递增排序轮次，也就是找到第  i 位置处应该放的 对应轮次最小值
  for (let i = 0; i < n - 1; i++) {
    // 内层循环用来比较：每轮比较之后最前面一个数字肯定是最小的数
    // 每轮循环都不需要比较前面的项，因此 j < (n - 1 - i) 
    let min = i // 内循环求最小值 赋值给索引 i  位置，先假设 i 位置就是最小值  
    for (let j = i + 1; j < n; j++) {
      if (arr[j] < arr[min]) {
        min = j
      }
    }
    swap(arr, i, min) // 将上面的最小值与 本轮索引 i 位置交换
    console.log(arr.toString()); // 将每轮的结果输出，需要观察的时候写上这句代码
  }
}


var nums = [10, 8, 3, 2, 2, 4, 9, 5, 4, 3]
selectSort(nums)
/* 结果
λ js eg-chapter12.2.js
2,8,3,10,2,4,9,5,4,3
2,2,3,10,8,4,9,5,4,3
2,2,3,10,8,4,9,5,4,3
2,2,3,3,8,4,9,5,4,10
2,2,3,3,4,8,9,5,4,10
2,2,3,3,4,4,9,5,8,10
2,2,3,3,4,4,5,9,8,10
2,2,3,3,4,4,5,8,9,10
2,2,3,3,4,4,5,8,9,10 */
```

##### 4.2.1.3 插入排序/简单插入排序（简单排序）

插入排序原理：
数组中有 n 个数，将无序数列中的元素插入到有序数列的对应位置，插入前通过比大小的方式找到其在有序数列中的对应位置。
第一轮索引 0  元素是有序的，带插入的元素为 索引 1 的元素， 将索引 1 元素值与前面已经排序好的 索引 0 元素比较，是否移动 索引 0 元素, **将待插入元素 索引 1 元素** 插入到适当的位置
第二轮索引 0,1  元素是有序的，带插入的元素为 索引 2 的元素， 将索引 2 元素值与前面已经排序好的 索引 0,1 元素比较是否移动，**将待插入元素 索引 2 元素** 插入到适当的位置
第三轮索引 0,1,2  元素是有序的，带插入的元素为 索引 3 的元素， 将索引 3 元素值与前面已经排序好的 索引 0,1,2 元素比较是否移动，**将待插入元素 索引 3 元素** 插入到适当的位置
.........
也就是说那么经过 n-1（数组的 length - 1） 轮，就可以完成所有数的排序。

**外层循环是控制循环轮次，获取待插入的元素，内层循环做元素的移动，找到合适的插入位置。然后再外层循环将待插入的元素插入到适合的位置。**

```JS
// 插入排序
function insertSort(arr) {
  let n = arr.length
  // 循环比较 n-1 次就可以完成排序，外层用来递增排序轮次
  // 第 1 轮：第 0 索引元素是一个有序的数列，第 1 个以后的是无序的序列，
  // 第 2 轮：第 0-1 索引元素是一个有序的数列，第 2 个以后的是无序的序列，
  for (let i = 1; i < n; i++) {
    let t = arr[i]
    var j = i - 1 //已经排好序的最后一个索引
    while (j >= 0 && arr[j] > t) {
      arr[j + 1] = arr[j] // 元素往后移动 arr[j] 往后移动到 arr[j + 1] 位置上
      j--
      // 内层循环用来比较：移动元素，找到适合的位置 j+1 ，注意不是 j
      // 当 arr[j] > t 不满足的时候结束内循环的，那么带插入的就应该是在 arr[j+1]
      // 带插入的元素,要用中间变量 t 保存下来，因为内层循环会改变它的值
      //（大的元素往后移动，数组元素被改变了,带插入元素还用 arr[i] 可能就不正确了）
      // 每轮循环比较的是 前面已经排序好的，也就是 arr[0]~arr[i-1]
    }
    arr[j + 1] = t
    console.log(arr.toString()); // 将每轮的结果输出，需要观察的时候写上这句代码
  }
}


var nums = [10, 8, 3, 2, 2, 4, 9, 5, 4, 3]
insertSort(nums)
/* 结果
λ js eg-chapter12.3.js
8,10,3,2,2,4,9,5,4,3
3,8,10,2,2,4,9,5,4,3
2,3,8,10,2,4,9,5,4,3
2,2,3,8,10,4,9,5,4,3
2,2,3,4,8,10,9,5,4,3
2,2,3,4,8,9,10,5,4,3
2,2,3,4,5,8,9,10,4,3
2,2,3,4,4,5,8,9,10,3
2,2,3,3,4,4,5,8,9,10 */
```

##### 4.2.1.4 三种简单排序的比较

**时间复杂度**：排序用时 ， **空间复杂度**：内存的占用

|排序方法|平均时间|最好时间|最坏时间||稳定性|空间复杂度|
|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|冒泡排序|O(n²)|O(n)|O(n²)||稳定|O(1)|
|选择排序|O(n²)|O(n²)|O(n²)||不稳定|O(1)|
|直接插入排序|O(n²)|O(n)|O(n²)||稳定|O(1)|

O(n)这样的标志叫做渐近时间复杂度,是个近似值.各种渐近时间复杂度由小到大的顺序如下

O(1) < O(logn) < O(n) < O(nlogn) < O(n^2) < O(n^3) < O(2^n) < O(n!) < O(n^n)

一般时间复杂度到了2^n(指数阶)及更大的时间复杂度,这样的算法我们基本上不会用了,太不实用了.比如递归实现的汉诺塔问题算法就是O(2^n).

平方阶(n^2)的算法是勉强能用,而nlogn及更小的时间复杂度算法那就是非常高效的算法 ,4.2.4 节就是高效的排序方法学习

冒泡排序,简单选择排序,堆排序,直接插入排序,希尔排序的空间复杂度为O(1),因为需要一个临时变量来交换元素位置,(另外遍历序列时自然少不了用一个变量来做索引)

快速排序空间复杂度为logn(因为递归调用了) ,归并排序空间复杂是O(n),需要一个大小为n的临时数组.

基数排序的空间复杂是O(n),桶排序的空间复杂度不确定

#### 4.2.2 高级排序

##### 4.2.1.1 几种高级排序的比较

|排序方法|平均时间|最好时间|最坏时间||稳定性|空间复杂度|
|:----:|:----:|:----:|:----:|:----:|:----:|:----:|
|桶排序|O(n)|O(n)|O(n)||不稳定|不确定|
|基数排序|O(n)|O(n)|O(n)||稳定|O(n)|
|归并排序|O(nlogn)|O(nlogn)|O(nlogn)||稳定|O(n)|
|快速排序|O(nlogn)|O(nlogn)|O(n^2)||不稳定|O(logn)|
|堆排序|O(nlogn)|O(nlogn)|O(nlogn)||不稳定|O(1)|
|希尔排序|O(n^1.25)||不稳定|O(1)|

所有排序算法中最快的应该是桶排序(很多人误以为是快速排序,实际上不是.不过实际应用中快速排序用的多)
**但桶排序一般用的不多,因为有几个比较大的缺陷.**

- 1.待排序的元素不能是负数,小数.
- 2.空间复杂度不确定,要看待排序元素中最大值是多少.

所需要的辅助数组大小即为最大元素的值.

##### 4.2.2.2 希尔排序/缩小增量排序（高级排序-简单插入排序的升级）

希尔排序是把记录按下标的一定 增量/间隔 gap 分组，对每组使用 直接插入排序算法/简单插入排序 进行排序；随着 增量/间隔 gap 逐渐减少，每组包含的元素越来越多，当增量减至1时，整个文数组元素恰被分成一组，算法便终止，得到了正确的排序。
希尔排序的基本思想是：先将整个待排序的记录序列分割成为若干子序列分别进行直接插入排序/简单插入排序，待整个序列中的记录基本有序时，再对全体记录进行依次直接插入排序/简单插入排序。

希尔排序是也加缩小增量排序，它基于简单插入排序做了改善。简单插入排序很循规蹈矩，不管数组分布是怎么样的，依然一步一步的对元素进行比较，移动，插入，比如[5,4,3,2,1,0]这种倒序序列，数组末端的0要回到首位置很是费劲，比较和移动元素均需n-1次。而希尔排序在数组中采用跳跃式分组的策略，通过某个增量将数组元素划分为若干组，然后分组进行插入排序，随后逐步缩小增量，继续按组进行插入排序操作，直至增量为1。希尔排序通过这种策略使得整个数组在初始阶段达到从宏观上看基本有序，小的基本在前，大的基本在后。然后缩小增量，到增量为1时，其实多数情况下只需微调即可，不会涉及过多的数据移动，简化了代码的执行，减少代码执行时间。

增量一般可以获取数组长度的一半，也就是 **希尔增量**：gap=length/2 ，缩小增量 gap=gap/2 ，实际上它不是最优的。后面我们使用动态间隔。

- 将有n个元素的数组分成n/2份，第1个数据与第n/2+1个数据属于同一份。。。
- 使用类似插入排序的方法，将同一份的数据排序
- 然后，再变为n/4份，同样的操作再次排序
- 不断重复上述3个步骤之后，最后分成n份数据，再通过一次插入排序就完成了全部的排序。

![tu](http://liuxmoo.foryung.com/7095972-23a069d787683d61.png)

```JS
// 希尔增量/间隔 gap=length/2
// 希尔函数，插入函数的升级版，用增量来给数组元素分组成多个组 使用直接插入算法排序，不断的减小增量来不断排序知道增量为1
function shellSort(arr) {
  let n = arr.length
  let gap = Math.floor(n / 2) //希尔增量
  while (gap >= 1) {
    // 外层循环控制 gap增量
    for (let i = gap; i < n; i++) {
      // 控制 每轮-每组 元素的待插入元素，arr[i]
      let t = arr[i]
      let j = i - gap
      while (j >= 0 && arr[j] > t) {
        // 元素比较移动
        arr[j + gap] = arr[j]
        j -= gap
      }
      // 插入元素
      arr[j + gap] = t
    }
    console.log(arr.toString())
    gap = Math.floor(gap / 2)
  }
}

/* console.log(3 / 2) //1.5 
console.log(Math.floor(3 / 2)) //1  Math.floor() 向下取整， 
go、Java 等语言中是自动取整的。JS中 3/2 是小数，需要取整！！！
*/
var nums = [8, 9, 1, 7, 2, 3, 5, 4, 6, 0]
var start = new Date().getTime();
shellSort(nums)
var stop = new Date().getTime();
var elapsed = stop - start;
print("shellSort " + elapsed + " ms"); // 10~50ms
// 对于小数组 100 位数排序来说用三大简单的排序！！只需要几毫秒，高级排序是给大数据数组用的

/* λ js eg-chapter12.5.js
3,5,1,6,0,8,9,4,7,2
0,2,1,4,3,5,7,6,9,8
0,1,2,3,4,5,6,7,8,9 */
```

```JS
// 动态增量
// 希尔函数，插入函数的升级版，用增量来给数组元素分组成多个组 使用直接插入算法排序，不断的减小增量来不断排序知道增量为1
function shellSort(arr) {
  let n = arr.length
  let gap = 1
  while (gap < n / 3) {
    gap = gap * 3 + 1 //循环动态定义增量-间隔序列：那为什么是3？？？有的是5？？？这里又是怎么取的？？
  }
  while (gap >= 1) {
    // 外层循环控制 gap增量
    for (let i = gap; i < n; i++) {
      // 控制 每轮-每组 元素的待插入元素，arr[i]
      let t = arr[i]
      let j = i - gap
      while (j >= 0 && arr[j] > t) {
        // 元素比较移动
        arr[j + gap] = arr[j]
        j -= gap
      }
      // 插入元素
      arr[j + gap] = t
    }
    console.log(arr.toString())
    gap = Math.floor(gap / 3)
  }
}

var nums = [8, 9, 1, 7, 2, 3, 5, 4, 6, 0]
var start = new Date().getTime();
shellSort(nums)
var stop = new Date().getTime();
var elapsed = stop - start;
print("shellSort " + elapsed + " ms"); // 10~40ms

/*
λ js eg-chapter12.6.js
2,0,1,4,6,3,5,7,8,9
0,1,2,3,4,5,6,7,8,9
shellSort 14 ms */
```

##### 4.2.2.3 快速排序/划分交换排序（高级排序-冒泡排序的升级）

快速排序（Quicksort）是对冒泡排序的一种改进。它的基本思想是：通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
快速排序是处理大数据集最快的排序算法之一。它是一种分而治之的算法，通过递归的方式将数据依次分解为包含较小元素和较大元素的不同子序列。该算法不断重复这个步骤直到所有数据都是有序的。 **但是注意不要重新创建两个子数组来存贮数据，这样就不是 in-place 方法了！！！**

快速排序是一个“交换类”的排序，以军训排队为例，教官说：“第一个同学出列，其他人以他为中心，比他矮的全排到他的左边，比他高的全排他右边。”这就是一趟快速排序。可以看出，一趟快速排序是以一个“枢轴”为中心，将序列分成两部分，枢轴的一边全是比它小（或者小于等于）的，另一边全是比他大（或者大于等于）的。

快速排序的实现：
①从数列中挑出一个元素，称为 "基准"（pivot）（通常以第一个元素作为基准），
②重新排序数列，所有元素比基准值小的摆放在基准前面，所有元素比基准值大的摆在基准的后面（相同的数可以到任一边）。在这个分区退出之后，该基准就处于数列的中间位置。
具体步骤：先 **从左 i=0 往右找比基准大的元素** 与 **从右 j=length-1 往左找比基准小的数字** 交换位置，当 i=j 时，停止比较，基准元素就放在这个索引位置。**注意一定是先右往左比较，再左往右比较，就是 j 先移动一步，然后 i 再移动一步**
③递归的去调用 1-2 步骤 直到 length<=1 这个子序列就是正确的排列的，最终得到的数字元素就是正确的排序的。

```JS
  // 下面是第一趟排序的实现过程
原始序列：
    49 38 65 97 76 13 27 49
    i                     j（ i 和 j 开始时分别指向头，尾元素）
    进行第一趟快速排序，以第一个数 49 作为枢纽（通常都选第一个元素作为枢纽），整个过程是一个交替扫描和交换的过程。
    ①使用 j，从序列最右端开始向前扫描，直到遇到比枢轴 49 小的数 27 ， j 停在这里。
    49 38 65 97 76 13 27 49
    i                  j
    ②使用 i，交换扫描方向，从前向后扫描，直到遇到比较枢轴 49 大的数 65 ，i 停在这里。
    49 38 65 97 76 13 27 49
          i            j
    ③将当前 i 与 j 位置的元素互换
    49 38 27 97 76 13 65 49
           i           j
    ④使用 j，交换扫描方向，从后向前扫描，直到遇到比枢轴 49 小的数 13 ， j 停在这里。
    49 38 27 97 76 13 65 49
          i        j
    ⑥使用 i，交换扫描方向，从前向后扫描，直到遇到比 49 大的数 97 ， i 停在这里。
    49 38 27 97 76 13 65 49
             i      j
    ⑦将当前 i 与 j 位置的元素互换
    49 38 27 13 76 13 65 49
             i      j
    ⑧使用 j，交换扫描方向，直到遇到比 49 小的数，当扫描到 i 与 j 相遇时，说明扫描过程结束了。
    27 38 13    76 97 65 49
             ij
    ⑨此时 i 等于 j 的这个位置就是枢轴 49 的最终位置，将 49 放入这个位置，第一趟快速排序结束。
    27 38 13 49 76 97 65 49
             ij
    // 如果是这样找到 大值小值相遇 那么就不需要做他们两的交换了
```

```JS
  // 再如下面是第一趟排序的实现过程
原始序列：
    3 9 9 2 8 7 0
    i           j（ i 和 j 开始时分别指向头，尾元素）
    进行第一趟快速排序，以第一个数 3 作为枢纽（通常都选第一个元素作为枢纽），整个过程是一个交替扫描和交换的过程。
    ①使用 j，从序列最右端开始向前扫描，直到遇到比枢轴 3 小的数 0 ， j 停在这里。
    3 9 9 2 8 7 0
    i           j
    ②使用 i，交换扫描方向，从前向后扫描，直到遇到比较枢轴 3 大的数 9 ，i 停在这里。
    3 9 9 2 8 7 0
      i         j
    ③将当前 i 与 j 位置的元素互换
    3 0 9 2 8 7 9
      i         j
    ④使用 j，交换扫描方向，从后向前扫描，直到遇到比枢轴 3 小的数 2 ， j 停在这里。
    3 0 9 2 8 7 9
      i   j
    ⑥使用 i，交换扫描方向，从前向后扫描，直到遇到比 3 大的数9 ， i 停在这里。
    3 0 9 2 8 7 9
        i j
    ⑦将当前 i 与 j 位置的元素互换
    3 0 2 9 8 7 9
        i j
    ⑧使用 j，交换扫描方向，j 往左移动遇到 i 了，此时扫描结束，
    3 0  2  9 8 7 9
         ij
    ⑨基数 3 与当前 ij位置交换，结束本轮交换。
    2 0 3 9 8 7 9

    本轮基数 3 到了最终排序的正确位置上了，下一轮将是  2 0   与  9 8 7 9 的递归扫描
```

```JS
// 快速排序-冒泡排序的升级版
// left 为左端起始索引， right 为右端索引 ，
// left 为子串第一个索引，right 为子串最后一个索引
// 原始调用 left=0 right=n-1 也就是数组的 第 0 与 n-1 索引位置
function quickSort(arr, left, right) {
  if (left >= right) return //递归出口
  let t = arr[left] //保存基数 
  var  i = left
  // 递归需要使用 left 与 right ，因此不能改变他们的值，循环使用的值 要创建新的变量来使用
  //quickSort(left, i - 1) // left 为最初传进来的值 ,这里的left不能被改变
  var  j = right
  while (i != j) { // i==j 的时候就是每轮的扫描结束，不比较了
    // 从右往左找 < 基数的元素，得到它当前的 j 值
    while (arr[j] >= t && j > i) {
      j--
    }
    // 从左往右找 > 基数的元素，得到它当前的 i 值
    while (arr[i] <= t && j > i) {
      i++
    }
    // 如果 arr[i] 与arr[j] 是同一个元素就没有必要做交换了，特别是当元素是很大的数据的话，交换需要成本
    // 比如 6 1 2 5 4 3 9 7 10 8 最后的 ij 是在3 相遇的，没有必要交换他们的位置的
    // 如果 3 是很大的对象元素，那么交换的成本是高的。i != j  或 i<j
    if (i < j) {
      let t1 = arr[j]
      arr[j] = arr[i]
      arr[i] = t1
    }
  }
  //将基数与当前的 ij 位置交换
  arr[left] = arr[i]
  arr[i] = t //0 9 i=6
  console.log(arr)
  quickSort(arr,left, i - 1) // left 为最初传进来的值 ,不要忘记 传arr
  quickSort(arr,i + 1, right) // right 为最初传进来的值 ,不要忘记 传arr
  
}

var nums = [8, 9, 1, 7, 2, 3, 5, 4, 6, 0]
var start = new Date().getTime();
quickSort(nums, 0, nums.length - 1)
var stop = new Date().getTime();
var elapsed = stop - start;
print("quickSort " + elapsed + " ms"); // 10~40ms

/*
λ js eg-chapter12.6.js
2,0,1,4,6,3,5,7,8,9
0,1,2,3,4,5,6,7,8,9
shellSort 14 ms */
```

##### 4.2.2.4 堆排序（高级排序）  

##### 4.2.2.5 归并排序（高级排序）

归并排序（MERGE-SORT）是建立在归并操作上的一种有效的排序算法,该算法是采用分治法（Divide and Conquer）的一个非常典型的应用。将已有序的子序列合并，得到完全有序的序列；即先使每个子序列有序，再使子序列段间有序。若将两个有序表合并成一个有序表，称为二路归并。

归并操作的工作原理如下：
第一步：申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
第二步：设定两个指针，最初位置分别为两个已经排序序列的起始位置
第三步：比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
重复步骤3直到某一指针超出序列尾
将另一序列剩下的所有元素直接复制到合并序列尾

##### 4.2.2.6 基数排序（高级排序）

##### 4.2.2.7 桶排序（高级排序）

### 4.3 检索算法

#### 4.3.1 顺序查找

顺序查找/线性查找：
适用于元素随机排列的列表；从列表的第一个元素开始对列表元素逐个进行判断，直到找到了想要的结果，或者直到列表结尾也没有找到。称为顺序查找。在执行查找时可能会访问到数据结构里的所有元素。

顺序查找的实现 ：
只要从列表的第一个元素开始循环，然后逐个与要查找的数据进行比较。如果匹配到了，则结束查找。如果到了列表的结尾也没有匹配到，那么这个数据就不存在于这个列表中。

```JS
// 顺序查找，就是从头开始查，可能会查到尾巴
function seqSearch(arr, data) {
  let n = arr.length
  for (let i = 0; i < n; i++) {
    if (arr[i] == data) {
      return i // return true
    }
  }
  return -1 // return false  // return null  
  // 使用 -1 比较好，返回相同的数据类型，在被调用的时候好做判断
}

function getMin(arr) {
  let n = arr.length
  let min = arr[0]
  for (let i = 0; i < n; i++) {
    if (arr[i] < min) {
      min = arr[i]
    }
  }
  return min
}

function getMin(arr) {
  let n = arr.length
  let max = arr[0]
  for (let i = 0; i < n; i++) {
    if (arr[i] > min) {
      max = arr[i]
    }
  }
  return max
}
```

如果需要找的数据在数组的开头那么很容易找到，如果恰好是在后面难么就很难找了。我们可以根据数据被查询的频率来改变数据在数组中的位置。比如，如果你是一个图书馆管理员，并且你在一天内会被问到好几次同一本参考书，那么你将会把这本书放在触手可及的地方。经过多次查找之后，查找最频繁的元素会从原来的位置移动到数据集的起始位置。这就是一个数据自组织的例子：数据的位置并非由程序员在程序执行之前就组织好，而是在程序运行过程中由程序自动组织的。

由于对数据的查找遵循“80-20 原则”，因此将你的数据转化为自组织的形式是很有意义的。“80-20 原则”是指对某一数据集执行的 80% 的查找操作都是对其中 20% 的数据元素进行查找。自组织的方式最终会把这 20% 的数据置于数据集的起始位置，这样便可以通过一个简单的顺序查找快速找到它们。类似这种“80-20 原则”的概率分布被称为帕累托（Pareto）分布，它是由帕累托（VilfredoPareto）在 19 世纪末期研究收入和财富的分布时发现的。更多关于数据集的概率分布可以参考高纳德（Donald Knuth）编写的《计算机程序设计艺术，卷 3：排序与查找》。

当数据位于数据集的前，20% 元素之外时，该数据才需要被重新移动到数据集的起始位置。

根据上面的原则，我们就可以将顺序查找元素更新如下，

```JS
function swap(arr, index1, index2) {
  let t = arr[index1]
  arr[index1] = arr[index2]
  arr[index2] = t
}

function seqSearch(arr) {
  let n = arr.length
  for (let i = 0; i < n; i++) {
    if (arr[i] == data) {
      if ( i > (arr.length * 0.2)) {
        swap(arr, i, 0)
        // 将查询的 i 位置 跟 i-1 位置交换掉
        // 当数据位于数据集的前，20% 元素之外时，该数据才需要被重新移动到数据集的起始位置。
      }
      return i
    }
  }
  return -1
}
```

#### 4.3.2 二分查找/折半搜索/二分搜索

二分查找：
适用于元素已排序的列表。二分查找效率更高，但是你必须在进行查找之前花费额外的时间将列表中的元素排序。 **二分查找算法，这个算法只对有序的数据集有效。**如果你要查找的数据是有序的，二分查找算法比顺序查找算法更高效。

二分查找实现：
元素是按升序排列，将表中间位置记录的关键字与查找关键字比较，如果两者相等，则查找成功；否则利用中间位置记录将表分成前、后两个子表，如果中间位置记录的关键字大于查找关键字，则进一步查找前一子表，否则进一步查找后一子表。重复以上过程，直到找到满足条件的记录，使查找成功，或直到子表不存在为止，此时查找不成功。

![tu](http://liuxmoo.foryung.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181028212718.png)

```JS
/ 二分查找 left  左限  ，right 右限
function binarySearch(arr, data) {
  let left = 0
  let right = arr.length - 1
  while (left <= right) {
    //let mid = Math.floor((left + right) / 2) 这样直接 (left + right) / 2 可以回溢出
    // 计算机位 64 位，有一位是符号位，那么 left 与 right 最大的情况是 2^63 + 2^63， 
    // 他们的结果，计算机无法保存。因为转化为如下，加法转化为减法运算
    // (left + right) / 2  等价于 left + (right - left) / 2
    let mid = Math.floor(left + (right - left) / 2)
    if (arr[mid] == data) {
      return mid
    } else if (arr[mid] > data) {
      right = mid - 1
    } else {
      left = mid + 1
    }
  }
  return -1 //没有找到
}

// 如果是递归：最初传入 left=0 ，right=length-1，
//能用循环就不要用递归，递归可能会写得麻烦,像这个二分查找的实现，递归就比循环要难思考了
function binarySearch1(arr, data, left, right) {
  if (left > right) {
    return -1
  }
  let mid = Math.floor(left + (right - left) / 2)
  if (arr[mid] == data) {
    return mid
  } else if (arr[mid] > data) {
    return binarySearch1(arr, data, left, mid - 1)
  } else {
    return binarySearch1(arr, data, mid + 1, right)
  }
}

var nums = []
for (let i = 0; i < 99; i++) {
  nums[i] = i + 1
}
console.log(binarySearch(nums, 82)) //81
console.log(binarySearch(nums, 1000)) //-1

console.log(binarySearch1(nums, 82, 0, 99)) //81
console.log(binarySearch1(nums, 1000, 0, 99)) //-1
```

统计某个数据的重复次数
如果这个数组是有序的，而且已经使用了二分查找了，那么我们可以像下面这样来查找。（如果是没有排序好的数组，数据又是很大的话，我们是可以用 字典 来做的，键值对比这些要好很多的，只是 字典 需要新内存）

```JS
// 对于排序好的数组
//var nums = [1,3,3,3] 这个数组找 3 返回的是 1  对于查找的数据，它返回它的索引， 我们需要统计它的重复次数，
// 用二分查找找到一个索引， 往右遍历得到右边的重复个数，往左遍历得到左边的重复个数，
// 那么最终得到的就是该数据的重复次数了

function count(arr, data) {
  let count = 0
  let index = binarySearch(arr, data)
  if (index != -1) {
    // data 在数据中存在，返回下标
    count++
    for (let i = index - 1; i >= 0; i--) {
      if (arr[i] == data) {
        count++
      } else {
        break // 不等的话，左边就不会有重复的数据了，跳出循环
      }
    }
    let n = arr.length
    for (let i = index + 1; i < n; i++) {
      if (arr[i] == data) {
        count++
      } else {
        break // 不等的话，左边就不会有重复的数据了，跳出循环
      }
    }
  }
  return count
}

var nums = [11, 23, 34, 34, 34, 34, 34, 56, 78, 99]
console.log(count(nums, 34)) //5
```

### 4.4 高级算法

#### 4.4.1 动态规划

递归：是从顶部开始将问题分解，通过解决掉所有分解出小问题的方式，来解决整个问题。（出现一样的小问题会不断的重复求解，浪费时间,效率不高）
动态规划：通过把原问题分解为相对简单的子问题的方式求解复杂问题的方法。（相同的子问题只会求解一边，然后将结果存储在数组中，下次调用即可）

动态规划常常适用于有重叠子问题[1]和最优子结构性质的问题，动态规划方法所耗时间往往远少于朴素解法。
动态规划背后的基本思想非常简单。大致上，若要解一个给定问题，我们需要解其不同部分（即子问题），再根据子问题的解以得出原问题的解。

通常许多子问题非常相似，为此动态规划法试图仅仅解决每个子问题一次，从而减少计算量：一旦某个给定子问题的解已经算出，则将其记忆化存储，以便下次需要同一个子问题解之时直接查表。这种做法在重复子问题的数目关于输入的规模呈指数增长时特别有用。

使用递归去解决问题虽然简洁，但效率不高。包括 JavaScript 在内的众多语言，不能高效地将递归代码解释为机器代码，尽管写出来的程序简洁，但是执行效率低下。但这并不是说使用递归是件坏事，本质上说，只是那些指令式编程语言和面向对象的编程语言对递归的实现不够完善，因为它们没有将递归作为高级编程的特性。

许多使用递归去解决的编程问题，可以重写为使用动态规划的技巧去解决。动态规划方案通常会使用一个数组来建立一张表，用于存放被分解成众多子问题的解。

##### 4.4.1.1 斐波那契数列

```JS
// 简单递归算法
//0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, …   该序列是由前两项数值相加而成的。
function fib(n) {
  if (n < 2) {
    return n
  }
  else {
    return fib(n-1) + fib(n-2)
  }
}
console.log(fb(10)); //  55
```

![tu](http://p1teq0wgy.bkt.clouddn.com/%E5%BE%AE%E4%BF%A1%E6%88%AA%E5%9B%BE_20181029174050.png)

从上面的递归树，我们看到很多函数（也就是子问题），被求解了很多遍，可以看出这个函数的效率是非常低的，该算法的运算时间是指数级增长的。
我们可以通过保存已经算出的子问题的解来避免重复计算：以将子函数的解存储下来，存储到一个 解的数组中，下次同样的子问题值需要访问数组元素即可得到解，不需要再次求解。这就是动态规划.那么上面的斐波那契数列递归函数，我们可以更新如下

```JS

//0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, …   该序列是由前两项数值相加而成的。
// 递归函数
function fib(n) {
  if (n < 2) {
    return n
  } else {
    return fib(n - 1) + fib(n - 2)
  }
}

//动态规划，用数组存贮数据 空间换时间，创建数组需要空间，但是时间大大的缩短了
function dynamicFib(n) {
  let arr = [] // 用来存储 f(0), f(1), f(2), f(3),也恶就是这里值的结果
  arr[0] = 0
  arr[1] = 1
  if (n < 2) {
    return n // 如果要求的很小就没有必要保存了，直接就是返回 n 就好了
  } else {
    // 如果需要求的 n 比较大，那么就像将这里结果放到数组中
    for (let i = 2; i <= n; i++) {
      arr[i] = arr[i - 1] + arr[i - 2]
    }
    return arr[n]
  }
}

var start = new Date().getTime()
fib(40)
var end = new Date().getTime()
var time = end - start
console.log(time + 'ms')

start = new Date().getTime()
dynamicFib(1000)
end = new Date().getTime()
time = end - start
console.log(time + 'ms')

/* 结果
λ js eg-chapter14.1.js
4383ms
1ms */
//可以看出，用递归函数需要几千毫秒，动态规划使用数组来存贮的话就仅仅是 1ms 的事情
```

##### 4.4.1.2 寻找最长公共子串

寻找两个字符串中最长的公共子串。

##### 4.4.1.3 背包问题（动态规划）

#### 4.4.2 贪心算法

贪心算法是一种以寻找“优质解”为手段从而达成整体解决方案的算法。这些优质的解决方案称为局部最优解，将有希望得到正确的最终解决方案，也称为全局最优解。“贪心”这个术语来自于这些算法无论如何总是选择当前的最优解这个事实。通常，贪心算法会用于那些看起来近乎无法找到完整解决方案的问题，然而，出于时间和空间的考虑，次优解也是可以接受的。

动态规划：基于递归方案实现的。对许多问题来说，采用动态规划的方式去处理有点大材小用，往往一个简单的算法就够了。那就是贪心算法。

贪心算法就是一种比较简单的算法。贪心算法总是会选择当下的最优解，而不去考虑这一次的选择会不会对未来的选择造成影响。使用贪心算法通常表明，实现者希望做出的这一系列局部“最优”选择能够带来最终的整体“最优”选择。如果是这样的话，该算法将会产生一个最优解，否则，则会得到一个次优。然而，对很多问题来说，寻找最优解很麻烦，这么做不值得，所以使用贪心算法就足够了

##### 4.4.2.1 找零问题

```JS
  //  美分： 1美分，10美分，25美分，50美分
  //  在所有面额都可用且数量不限的情况下，这种方案总能找到最优解。
  //  如果某种面额不可用，比如 5 美分，则会得到一个次优解。
```

##### 4.4.2.2 背包问题（贪心算法）