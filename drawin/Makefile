nvim-env-build:
	docker buildx build --platform=linux/amd64 -t neovim .

nvim-run:
	docker run -it --rm -v `pwd`/lazyvim:/root/.config/nvim neovim
