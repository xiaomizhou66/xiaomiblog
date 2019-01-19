---
title: react.js--API
date: '2018/8/19 23:57:28'
categories:
  - 五、react.js
  - react.js 框架学习
abbrlink: '828e3366'
updated:
tags:
comments:
---

# 一、前言

# 二、React 对象

不用 函数创建小组件了么？？？？？？

## 2.1 React.Component 创建带 state 的组件

```JS
class Greeting extends React.Component {// 组件使用 React.Component  这个 API 来创建，但是这面的App 也是组件怎么不一样呢？？
  render() {
    return <h1>Hello, {this.props.name}</h1>;  // props 是隐式传来的。
  }
}
```

```JS
import React, { Component } from 'react'; // 默认导出 React，命名导出  Component
//Component是一个命名导出。例如，它必须用{}进行解构。相当于下面，所以这些直接使用 Component
// import React from 'react'
// let Component = React.Component
import logo from './logo.svg';
import './App.css';

class App extends Component {
  render() {
    return (
      // 注意到这里， 它的类 class 写成 className 因为这里是 JS 在 ES6 中 class 为保留字 具体去看 2.4 DOM 元素 章节学习
      // className 后面跟着的名称 还是大写开头的？？？？
      // 同样还有一个 for 写成 htmlFor，因为 for 是个保留字
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
        </header>
      </div>
    );
  }
}

export default App;
```

## 2.2 React.PureComponent 创建组件

React.PureComponent 与 React.Component 几乎完全相同，

区别：
React.Component **它没有实现**shouldComponentUpdate()，？？？？？？？
React.PureComponent 通过 prop 和 state 的 浅对比 来实现 shouldComponentUpate()。？？？？？？？？？？？？？？？？？？？？？？
如果 React 组件的 render() 函数在给定相同的 props 和 state 下渲染为相同的结果，在某些场景下你可以使用 React.PureComponent 来提升性能。？？？？？？？

注意
`React.PureComponent shouldComponentUpdate()`只是浅析对象。如果这些包含复杂的数据结构，则可能会产生错误的负面因素，从而产生更深层 只有 PureComponent 在您希望拥有简单的道具和状态时才会扩展，或者 forceUpdate() 在您知道深层数据结构发生变化时使用。或者，考虑使用不可变对象来促进嵌套数据的快速比较。

此外，React.PureComponent 的 shouldComponentUpdate() 跳过整个组件树道具更新。确保所有 子组件也“纯净”。

## 2.3 React.memo 创建组件

```JS
const MyComponent = React.memo(function MyComponent(props) {
  /* render using props */
});
```

React.memo 是一个 更高阶的组件。它类似于 React.PureComponent 功能组件而 不是类。

如果你的 **函数组件**在给定相同的道具的情况下呈现相同的结果，则可以 React.memo 通过记忆结果将其包装在一些调用中以提高性能。这意味着React 将跳过渲染组件，并重用最后渲染的结果。

默认情况下，它只会 浅显 比较 props 对象中的复杂对象。如果要控制比较，还可以提供自定义比较功能作为第 2 个参数。

```JS
function MyComponent(props) {
  /* render using props */
}
function areEqual(prevProps, nextProps) {
  /*
  return true if passing nextProps to render would return
  the same result as passing prevProps to render,
  otherwise return false
  */
}
export default React.memo(MyComponent, areEqual);
//此方法仅作为性能优化存在。不要依赖它来“防止”渲染，因为这会导致错误。
```

注意

与 shouldComponentUpdate() 类组件上的方法不同，如果道具相等且道具不相等，则 areEqual 函数返回。这是相反的。truefalseshouldComponentUpdate

## 2.4 React.createElement()

```JS
React.createElement(
  type,
  [props],
  [...children]
)
//创建并返回 给定类型 的新 React元素。
// type 参数可以是标记名称字符串（如 'div'  or 'span'），React 组件类型（类或函数）或 React 片段类型。

//用 JSX 编写的代码将转换为使用 React.createElement()。
// React.createElement() 如果您使用的是 JSX，通常不会直接调用。请参阅 React Without JSX 以了解更多信息。
```

## 2.5 React.createFactory()

```JS
React.createFactory(type)
// 返回一个生成 给定类型 的 React 元素 的函数。
// 例如 React.createElement()，type 参数可以是标记名称字符串（例如 'div'  or 'span'），
// React 组件类型（类或函数）或 React 片段类型。
```

这个帮助程序被认为是遗留的，我们建议您使用 JSX 或 React.createElement() 直接使用。

React.createFactory() 如果您使用的是 JSX，通常不会直接调用。请参阅 React Without JSX 以了解更多信息。

## 2.6 React.cloneElement()

```JS
React.cloneElement(
  element,
  [props],
  [...children]
)
//克隆并返回一个新的 React 元素 element 作为起点。
// 结果元素 将具有 原始元素 的道具，新道具以浅层方式合并。新的孩子将取代现有的孩子。key 并 ref 保留原始元素。
```

React.cloneElement() 几乎相当于：

`<element.type {...element.props} {...props}>{children}</element.type>`
但是，它也保留了refs。这意味着如果你的孩子上面有一个孩子 ref，你就不会意外地从你的祖先那里偷走它。您将获得与 ref 新元素相同的附加内容。

引入此 API 作为已弃用的替代品 React.addons.cloneWithProps()。

## 2.7 React.isValidElement()

```JS
React.isValidElement(object)
// 验证 对象 是否为 React元素。返回 true 或 false。
```

## 2.8 React.Children

React.Children 提供用于处理 this.props.children 不透明数据结构的实用程序。

### 2.8.1 React.Children.map

```JS
React.Children.map(children, function[(thisArg)])
```

上调用包含在每一个直系子的功能 children 与 this 设置为 thisArg。如果 children 是一个数组，它将被遍历，并且将为数组中的每个子节点调用该函数。如果孩子是 null 或者 undefined，这个方法将返回 null 或者 undefined 不是数组。

注意

如果 children 是 a Fragment，它将被视为 单个孩子 而 不是被遍历。

### 2.8.2 React.Children.forEach

```JS
React.Children.forEach(children, function[(thisArg)])
// 喜欢 React.Children.map() 但不返回数组。
```

### 2.8.3 React.Children.count

```JS
React.Children.count(children)
// 返回组件的总数 children，等于回调传递给 map 或 forEach 将被调用的次数。
```

### 2.8.4 React.Children.only

```JS
React.Children.only(children)
// 验证 children 只有一个子节点（React 元素）并返回它。否则此方法会引发错误。

//注意：
//React.Children.only() 不接受返回值，React.Children.map() 因为它是一个数组而不是一个 React 元素。
```

### 2.8.5 React.Children.toArray

```JS
React.Children.toArray(children)
// 将 children 不透明数据结构作为平面数组返回，并为每个子项分配键。
// 如果要在渲染方法中操作子集合，则非常有用，尤其是在要将其 this.props.children 传递之前重新排序或切片时。

//注意：
//React.Children.toArray() 在展平子项列表时更改键以保留嵌套数组的语义。
// 也就是说，toArray 在返回的数组中为每个键添加前缀，以便每个元素的键的范围限定为包含它的输入数组。
```

## 2.9 React.Fragment

```JS
//该 React.Fragment 组件允许您在 render() 方法中 返回多个元素，而无需创建其他 DOM 元素：

render() {
  return (
    <React.Fragment>
      Some text.
      <h2>A heading</h2>
    </React.Fragment>
  );
}
// 您也可以使用简写 <></> 语法来使用它。有关更多信息，请参阅 React v16.2.0：改进对片段的支持。
```

## 2.10 React.forwardRef

```JS
// React.forwardRef 创建一个 React 组件，它将它接收的 ref 属性转发到树下面的另一个组件。这种技术不常见，但在两种情况下特别有用：

//转发引用 DOM 组件
//转发更高阶组件的 refs
//React.forwardRef 接受渲染函数作为参数。React 将使用 props 和 ref 作为两个参数调用此函数。此函数应返回 React 节点。

const FancyButton = React.forwardRef((props, ref) => (
  <button ref={ref} className="FancyButton">
    {props.children}
  </button>
));

// You can now get a ref directly to the DOM button:
const ref = React.createRef();
<FancyButton ref={ref}>Click me!</FancyButton>;
// 在上面的示例中，React ref 将给定 <FancyButton ref={ref}> 元素作为第二个参数传递给 React.forwardRef 调用内的呈现函数。
//此渲染函数将元素传递 ref 给 <button ref={ref}> 元素。

// 因此，在 React 附加 ref 之后，ref.current 将直接指向 <button>DOM 元素实例。
// 有关更多信息，请参阅转发引用。
```

```JS
function enhance(Component) {
  class Enhanced extends React.Component {
    // ...
    render() {
      const {forwardedRef, ...rest} = this.props;
      // Assign the custom prop "forwardedRef" as a ref
      return <Component ref={forwardedRef} {...rest} />;
    }
  }
  // Intercept the "ref" and pass it as a custom prop, e.g. "forwardedRef"
  function enhanceForwardRef(props, ref) {
    return <Enhanced {...props} forwardedRef={ref} />;
  }
  // These next lines are not necessary,
  // But they do give the component a better display name in DevTools,
  // e.g. "ForwardRef(withTheme(MyComponent))"
  const name = Component.displayName || Component.name;
  enhanceForwardRef.displayName = `enhance(${name})`;
  return React.forwardRef(enhanceForwardRef);
}
```

## 2.11 React.createRef

```JS
// React.createRef 创建一个裁判可以附着经由 ref 属性反应的元素。

class MyComponent extends React.Component {
  constructor(props) {
    super(props);
    this.inputRef = React.createRef();
  }

  render() {
    return <input type="text" ref={this.inputRef} />;
  }

  componentDidMount() {
    this.inputRef.current.focus();
  }
}
```

## 2.12 React.lazy

React.lazy() 允许您定义动态加载的组件。这有助于减少包大小以延迟加载在初始渲染期间未使用的组件。

您可以从我们的代码拆分文档中学习如何使用它。您可能还想查看本文，详细说明如何使用它。

```JS
// This component is loaded dynamically
const SomeComponent = React.lazy(() => import('./SomeComponent'));
//请注意，渲染 lazy 组件要求 <React.Suspense> 渲染树中有一个更高的组件。这是您指定加载指示器的方式。
```

## 2.13 React.Suspense

React.Suspense 让你指定加载指示器，以防它下面的树中的某些组件尚未准备好渲染。今天，延迟加载组件是唯一支持的用例 `<React.Suspense>`：

```JS
// This component is loaded dynamically
const OtherComponent = React.lazy(() => import('./OtherComponent'));

function MyComponent() {
  return (
    // Displays <Spinner> until OtherComponent loads
    <React.Suspense fallback={<Spinner />}>
      <div>
        <OtherComponent />
      </div>
    </React.Suspense>
  );
}
```

它在我们的代码拆分指南中有记录。请注意，lazy 组件可以位于 Suspense 树的深处- 它不必包装它们中的每一个。最佳做法是将 `<Suspense>` 您想要查看加载指示符的位置放置在您想要进行 lazy() 代码拆分的任何位置。

虽然今天不支持，但未来我们计划 Suspense 处理更多场景，例如数据获取。您可以在我们的路线图中了解这一点。

注意：

React.lazy() 并且 `<React.Suspense>` 尚未得到支持 `ReactDOMServer`。这是一个已知的限制，将来会解决。

# 三、 ReactDOM 对象

## 3.1 ReactDOM.render() 渲染函数：将 react 元素渲染到 html 中

是 React 的最基本方法，用于将模板转为 HTML 语言，并插入指定的 DOM 节点。

```JS
ReactDOM.render(
  element,
  container,
  [callback]//回调函数是可选的。如果你提供了，程序会在渲染或更新之后执行这个函数。
)
// 渲染一个 React 元素，添加到位于提供的 container 里的 DOM 元素中，并返回这个组件的一个 引用 (或者对于无状态组件返回 null ).
// 如果这个 React 元素 之前 已经 被渲染到 container 里去了，这段代码就会进行一次 更新 ，
// 并且只会改变那些反映元素最新状态所必须的 DOM 元素。
```

## 3.2 ReactDOM.unmountComponentAtNode() 移除渲染的 组件

```JS
ReactDOM.unmountComponentAtNode(container)
// 从 DOM 元素中移除已挂载的 React 组件，清除它的事件处理器和 state。
// 如果容器内没有挂载任何组件，这个函数什么都不会干。 有组件被卸载的时候返回 true，没有组件可供卸载时返回 false。
```

## 3.3 ReactDOM.findDOMNode() 在大部分情况下都 不提倡 使用这个方案，因为它破坏了组件的抽象化。

```JS
ReactDOM.findDOMNode(component)
// 如果这个组件已经被挂载到 DOM 中，函数会返回对应的浏览器中生成的 DOM 元素 。
// 当你需要从 DOM 中读取值时，比如表单的值，或者计算 DOM 元素的尺寸，这个函数会非常有用。
// 大多数情况下，你可以添加一个指向 DOM 节点的引用，从而完全避免使用 findDOMNode 这个函数.
// 当 render 返回 null 或者 false 时, findDOMNode 也返回 null.
```

## 3.4 实例

```JS
ReactDOM.render(
  <h1>Hello, world!</h1>,// element 这个是 react 元素
  document.getElementById('example')// container 容器
);
//上面代码将一个 h1 标题，插入 example 节点

ReactDOM.unmountComponentAtNode(document.getElementById('example'))
```

# 四、ReactDOMServer 对象

## 4.1 ReactDOMServer.renderToString() 服务端使用/ReactDOMServer.renderToStaticMarkup()

```JS
ReactDOMServer.renderToString(element) //把一个 Reac t元素渲染为原始的HTML。 这个方法最好 只在服务端使用!!!!!!!!!!!!
  //React 将会返回一段 HTML 字符串。你可以用这个方法在服务端生成 HTML，并根据初始请求发送标记来加快页面的加载速度，
  //同时让搜索引擎可以抓取你的页面来达到优化 SEO 的目的
ReactDOMServer.renderToStaticMarkup(element)
  //类似 renderToString，但是不会创建额外的 DOM 属性，例如 data-reactid 这些仅在 React 内部使用的属性。
  // 如果你希望把 React 当作一个简单的静态页面生成器来使用，这很有用，因为去掉额外的属性可以节省很多字节。
```

# 五、 DOM 元素（与 html 的 DOM 有区别）

React 实现了一套与浏览器无关的 DOM 系统，兼顾了性能和跨浏览器的兼容性。借此机会，我们清理了浏览器 DOM 实现中一些不一致的问题。

## 5.1 命名规则

在 React 中，所有的 DOM **特性和属性** **包括事件处理函数** 都是 **小驼峰命名**法命名。（因为它们是 JS 拓展代码，而不是 html）
比如说，
① tabindex 属性对应的 React 实现命名则是 tabIndex。？？？？？                属性名是驼峰形式
② className="App-header",为什么首字母要大写？？？？？？？，这个是 create-react-app 初始化项目来的。 className属性值首字母大写么？
   在 JS 中 className 是大小写敏感的哦。
③ aria-* 和 data-* 属性是例外的，一律使用小写字母命名。

```JS
<div className="App">
  <header className="App-header">
    <img src={logo} className="App-logo" alt="logo" />
    <p>
      Edit <code>src/App.js</code> and save to reload.
    </p>
    <a
      className="App-link"
      href="https://reactjs.org"
      target="_blank"
      rel="noopener noreferrer"
    >
      Learn React
    </a>
  </header>
</div>
```

## 5.2 React 和 HTML 的 DOM 属性的区别

有许多的属性在React和Html之间行为是不一样的：

### 5.2.1 checked 属性??????????

`<input>`标签 type 属性值为 checkbox 或 radio 时，支持 checked 属性。这对于构建受控组件很有用。
与之相对 defaultChecked 这是非受控组件的属性，用来设定对应组件首次加载时是否选中状态。

### 5.2.2 类名属性 className (特殊情况还是使用 class)

在 React 中，使用 className 属性指定一个 CSS 类 (class) 。这个特性适用于所有的常规 DOM 节点和 SVG 元素，比如 `<div>`，`<a>` 和其它的元素。

**特殊情况**:如果你在 React 中使用 Web 组件（这是一种不常见的使用方式），请使用 class 属性。

### 5.2.3 dangerouslySetInnerHTML 函数(react DOM 获取标签/组件 内内容)

```JS
// dangerouslySetInnerHTML 是 React 提供的替换浏览器 DOM 中的 innerHTML 接口的一个函数。

//一般而言，使用 JS 代码设置 HTML 文档的内容是危险的，因为这样很容易把你的用户信息暴露给跨站脚本攻击.
//所以，你虽然可以直接在 React 中设置 html 的内容，但你要使用 dangerouslySetInnerHTML 并向该函数传递一个含有 __html 键的对象，
//用来提醒你自己这样做很危险。例如：

function createMarkup() {
  return {__html: 'First &middot; Second'};// &middot; 在中间的一个句号
}

function MyComponent() {
  return <div dangerouslySetInnerHTML={createMarkup()} />;
}
```

## 5.3 htmlFor

因为在 javascript 中 for 是一个保留字，所以 React 元素使用 htmlFor 代替。

```JS
<label htmlFor={this.props.forId}></label>
```

## 5.4 onChange 函数

onChange 事件处理函数的表现正如你所期望的：无论 form 表单何时发生变化，这个事件都会被触发。我们特意不使用浏览器已有的默认行为，因为onChange 在浏览器中的表现和这个名字不相称，而且 React 真实依靠这个事件实现了对用户输入的实时响应处理。

## 5.5 selected

组件支持 selected 属性。你可以使用该属性设定组件是否选中的状态。这对构建受控组件很有用。

## 5.6 style属性

style 属性接受一个键为 **小驼峰命名**法命名的 javascript 对象作为值，而不是像 css 字符串。
这和 DOM 中 style 属性接受 javascript 对象对象 key 的命名方式保持一致性，**更高效而且能够防止跨站脚本（XSS）的安全漏洞**。例如：

```JS
const divStyle = {
  color: 'blue',
  backgroundImage: 'url(' + imgUrl + ')',
};

function HelloWorldComponent() {
  return <div style={divStyle}>Hello World!</div>;
}


// 要注意，样式属性不会自动补齐前缀的。为了支持旧的浏览器，你需要手动支持相关的样式特性：像下面一样
const divStyle = {
  WebkitTransition: 'all', // note the capital 'W' here
  msTransition: 'all' // 'ms' is the only lowercase vendor prefix
};

function ComponentWithTransition() {
  return <div style={divStyle}>This should work cross-browser</div>;
}
```

样式 key 使用 **小驼峰命名法** 是为了和 JS 访问 DOM 特性对对象的处理保持一致性（例如 node.style.backgroundImage）。
**浏览器后缀**除了 ms 以外，都应该以 **大写字母开头**。这就是为什么 WebkitTransition 有一个大写字母 W 。

## 5.7 suppressContentEditableWarning

一般来说，当一个拥有子节点的元素被标记为 contentEditable 时，React 会发出一个警告信息，因为此时 contentEditable 是无效的。这个属性会触发这样的警告信息。一般不要使用这个属性，除非你要构建一个类似 Draft.js 这样需要手动处理 contentEditable 属性的库。

## 5.8 value

`<input>` 和 `<textarea>` 组件都支持 value 属性。你可以使用该属性设置组件的值。这对构建受控组件非常有用。defaultValue 属性对应的是非受控组件的属性，用来设置组件第一次加载时的值。

## 5.9 react 所有受支持的 HTML 属性

### 5.9.1 React 支持以下所有的属性，同时也支持所有的 data-* 和 aria-* 属性：

```BASH
classID className style # 样式属性
selected value form formAction formEncType formMethod # 表单

accept acceptCharset accessKey action allowFullScreen allowTransparency alt
async autoComplete autoFocus autoPlay capture cellPadding cellSpacing challenge
charSet checked cite  colSpan cols content contentEditable
contextMenu controls coords crossOrigin data dateTime default defer dir
disabled download draggable encType  
formNoValidate formTarget frameBorder headers height hidden high href hrefLang
htmlFor httpEquiv icon id inputMode integrity is keyParams keyType kind label
lang list loop low manifest marginHeight marginWidth max maxLength media
mediaGroup method min minLength multiple muted name noValidate nonce open
optimum pattern placeholder poster preload profile radioGroup readOnly rel
required reversed role rowSpan rows sandbox scope scoped scrolling seamless
shape size sizes span spellCheck src srcDoc srcLang srcSet start step
summary tabIndex target title type useMap  width wmode wrap
```

### 5.9.2 React 也支持以下这些 RDFa 属性（有几个 RDFa 属性 和 HTML 属性重叠，所以不包含在以下列表中）：

而且，React也支持下列非标准属性：

autoCapitalize autoCorrect for Mobile Safari.
color for <link rel="mask-icon" /> in Safari.
itemProp itemScope itemType itemRef itemID for HTML5 microdata.
security for older versions of Internet Explorer.
unselectable for Internet Explorer.
results autoSave for WebKit/Blink input fields of type search.

## 5.10 所有受支持的SVG属性

```BASH
accentHeight accumulate additive alignmentBaseline allowReorder alphabetic
amplitude arabicForm ascent attributeName attributeType autoReverse azimuth
baseFrequency baseProfile baselineShift bbox begin bias by calcMode capHeight
clip clipPath clipPathUnits clipRule colorInterpolation
colorInterpolationFilters colorProfile colorRendering contentScriptType
contentStyleType cursor cx cy d decelerate descent diffuseConstant direction
display divisor dominantBaseline dur dx dy edgeMode elevation enableBackground
end exponent externalResourcesRequired fill fillOpacity fillRule filter
filterRes filterUnits floodColor floodOpacity focusable fontFamily fontSize
fontSizeAdjust fontStretch fontStyle fontVariant fontWeight format from fx fy
g1 g2 glyphName glyphOrientationHorizontal glyphOrientationVertical glyphRef
gradientTransform gradientUnits hanging horizAdvX horizOriginX ideographic
imageRendering in in2 intercept k k1 k2 k3 k4 kernelMatrix kernelUnitLength
kerning keyPoints keySplines keyTimes lengthAdjust letterSpacing lightingColor
limitingConeAngle local markerEnd markerHeight markerMid markerStart
markerUnits markerWidth mask maskContentUnits maskUnits mathematical mode
numOctaves offset opacity operator order orient orientation origin overflow
overlinePosition overlineThickness paintOrder panose1 pathLength
patternContentUnits patternTransform patternUnits pointerEvents points
pointsAtX pointsAtY pointsAtZ preserveAlpha preserveAspectRatio primitiveUnits
r radius refX refY renderingIntent repeatCount repeatDur requiredExtensions
requiredFeatures restart result rotate rx ry scale seed shapeRendering slope
spacing specularConstant specularExponent speed spreadMethod startOffset
stdDeviation stemh stemv stitchTiles stopColor stopOpacity
strikethroughPosition strikethroughThickness string stroke strokeDasharray
strokeDashoffset strokeLinecap strokeLinejoin strokeMiterlimit strokeOpacity
strokeWidth surfaceScale systemLanguage tableValues targetX targetY textAnchor
textDecoration textLength textRendering to transform u1 u2 underlinePosition
underlineThickness unicode unicodeBidi unicodeRange unitsPerEm vAlphabetic
vHanging vIdeographic vMathematical values vectorEffect version vertAdvY
vertOriginX vertOriginY viewBox viewTarget visibility widths wordSpacing
writingMode x x1 x2 xChannelSelector xHeight xlinkActuate xlinkArcrole
xlinkHref xlinkRole xlinkShow xlinkTitle xlinkType xmlns xmlnsXlink xmlBase
xmlLang xmlSpace y y1 y2 yChannelSelector z zoomAndPan
```