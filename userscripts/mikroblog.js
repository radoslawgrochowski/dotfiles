// ==UserScript==
// @name         Mikroblog Utilities
// @author       radoslawgrochowski
// @match        http*://www.wykop.pl/mikroblog/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';
    console.log('script loaded');

    const addGlobalStyle = (css) => {
		const head = document.getElementsByTagName('head')[0];
		if (!head) { return; }
		const style = document.createElement('style');
		style.type = 'text/css';
		style.innerHTML = css.replace(/;/g, ' !important;');
		head.appendChild(style);
	}
	window.addGlobalStyle = addGlobalStyle;

	//clean;
	addGlobalStyle(`
	  .grid-right{
		display: none;
	  }
	  .grid-main{
		margin: 0 167.5px;
	  }
	  #footer{
	    display: none;
	  }
	  #site {
		margin: 0;
		padding: 50px 0 0 0 0;
		height: 100%;
	  }
	`);

	const addMoreMenuOptions = () => {
		const menuEl = document.querySelector("div.nav.bspace.rbl-block > ul");
		menuEl.innerHTML = '';
		[1, 2, 3, 4, 6, 8, 12, 24].forEach(n => {
			const li = document.createElement('li');
			li.innerHTML = `<a href="https://www.wykop.pl/mikroblog/hot/ostatnie/${n}/" title="">${n}h</a>`;
			menuEl.append(li);
		});
	};
	addMoreMenuOptions();

	const isScrolledToBottom = () => document.documentElement.scrollTop / (document.documentElement.scrollHeight - document.documentElement.clientHeight) === 1;

	const getCurrentPageNumber = () => {
		const address = window.location.href
		if(address.match(/strona/)){
			return address.split('/').filter(Boolean).slice(-1)[0];
		}
		return 1;
	}

	let lastFetchedPage = getCurrentPageNumber();
	let isFetching = false;

	const getNextPageAddress = () => {
		return `https://www.wykop.pl/mikroblog/hot/strona/${lastFetchedPage + 1}/`
	}

    const refreshImages = () => {
		Array.from(document.querySelectorAll('img[data-original]')).forEach(el => {
			if(el.hasAttribute('src')){
				return;
			}
			el.setAttribute('src', el.getAttribute('data-original'));
		});
    }

	const setPanelText = (message) => {
		const el = document.querySelector("#content > div.wblock.rbl-block.pager");
		el.innerHTML = message;
	}

	const scrollHandle = () => {
		if(isFetching || !isScrolledToBottom() || lastFetchedPage >= 10){
			return;
        }
		document.querySelector("#content > div.wblock.rbl-block.pager")
	    isFetching = true;
		setPanelText(`Ładowanie następnej strony`);
		fetch(getNextPageAddress())
			.then(r => r.text())
			.then(response => {
				const htmlObject = document.createElement('div');
				htmlObject.innerHTML = response;
				const currentItems = document.querySelector('#itemsStream');
				Array.from(htmlObject.querySelector('#itemsStream').children).forEach(element => {
					currentItems.appendChild(element);
				});
				lastFetchedPage = lastFetchedPage + 1;
				isFetching = false;
				setPanelText('');
			}).then(refreshImages);
	}

	window.addEventListener('scroll', scrollHandle)
})();
