var pages = [];
var pageMap = {};
var lastShownPageId = null;

function setup () {
    var style = document.createElement("link");
    style.setAttribute("rel", "stylesheet");
    style.setAttribute("href", "Resources/Style.css");
    document.getElementsByTagName("head")[0].appendChild(style);
    
    var content = document.getElementById("content");
    var children = content.childNodes;
    
    for (var i = 0; i < children.length; i ++) {
        var child = children[i];
        if (child.className != "Page") continue;
        
        
        var page = {
            id: child.id,
            element: child,
            index: pages.length
        };
        
        pages.push(page);
        pageMap[page.id] = page;
    }
    
};

function showPage(id) {
    var page = pageMap[id];
    if (!page) return;
    
    for (var i = 0; i < pages.length; i ++) {
        pages[i].element.className = "Page";
    }
    
    page.element.className = "Page TargetPage";
      
    lastShownPageId = id;
};

function checkUrl() {
    try {
        if (window.location.href.match(/#(.*)$/)) {
            var id = RegExp.$1;
            if (lastShownPageId != id) {
                showPage(id);
            }
        } else {
            if (pages.length > 0) {
                var firstPage = pages[0];
                showPage(firstPage.id);
                window.location.href = "#" + firstPage.id;
            }
        }
    } finally {
        window.setTimeout(checkUrl, 200);
    }
}

window.onload = function () {
    setup();
    checkUrl();
};
