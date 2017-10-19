

const WeexMapcomponent = {
  show() {
      alert("module WeexMapcomponent is created sucessfully ")
  }
};


var meta = {
   WeexMapcomponent: [{
    name: 'show',
    args: []
  }]
};



if(window.Vue) {
  weex.registerModule('WeexMapcomponent', WeexMapcomponent);
}

function init(weex) {
  weex.registerApiModule('WeexMapcomponent', WeexMapcomponent, meta);
}
module.exports = {
  init:init
};
