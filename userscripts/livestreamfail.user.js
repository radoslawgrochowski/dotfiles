// ==UserScript==
// @name         LivestreamFail Hide Visited
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://www.reddit.com/r/LivestreamFail/
// @grant         GM_setValue
// @grant         GM_getValue
// ==/UserScript==

(function() {
  "use strict";
  window.addEventListener("load", async () => {
    console.log("LivestreamFail Hide Visited Loaded");
    const getElementByXpath = (path) => document.evaluate(path, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;

    const getVisited = async () => {
      return typeof GM_getValue !== "undefined" && GM_getValue("visited") || [];
    };

    if(!Array.isArray(await getVisited())){
      console.log('visited is not array')
      await GM_setValue('visited', [])
    }

    const cleanupVisited = async () => {
      const oldVisited = await getVisited();
      const newVisited = [...[...new Set([...oldVisited].reverse().slice(0, 100))].reverse()];
      console.log("visited cleaned up", { oldVisited, newVisited });
      GM_setValue("visited", newVisited);
    };


    const content = getElementByXpath("//*[@id=\"SHORTCUT_FOCUSABLE_DIV\"]/div[2]/div/div/div/div[2]/div[3]/div[1]");

    const addHandlerToLinks = async () => {
      const anchors = Array.from(content.querySelectorAll(`a[href^="https://clips"]:not([data-handled])`));
      const visited = await getVisited()
      anchors.forEach(async x => {
        x.setAttribute("data-handled", 1);
        if (visited.includes(x.href)) {
          x.parentElement.parentElement.parentElement.remove();
        }
        x.addEventListener('mousedown', () => {
          setTimeout(async () => {
            const visited = await getVisited()
            if (!visited.includes(x.href)) {
              GM_setValue("visited", [...visited, x.href]);
            }
            console.log(`visited: ${x.href}`);
          }, 1000);
        });
      });
    };

    addHandlerToLinks();
    cleanupVisited();
    setInterval(() => {
      addHandlerToLinks();
    }, 5000);
  });
})();
