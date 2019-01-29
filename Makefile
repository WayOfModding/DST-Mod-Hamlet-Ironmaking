
clean:
	rm ".editorconfig"
	find . \( -iname "*.psd" -or -iname "*.png" -or -iname "*.md" \) -delete
	rm -r "screenshots/"
	rm "Makefile"