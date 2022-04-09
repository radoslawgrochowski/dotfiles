stow_all: 
	stow --verbose --target=$$HOME --restow */

unstow_all:
	stow --verbose --target=$$HOME --delete */
 
