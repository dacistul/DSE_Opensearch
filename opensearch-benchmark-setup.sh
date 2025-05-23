sudo apt update
sudo apt upgrade -y

sudo apt install -y make build-essential libssl-dev zlib1g-dev \
	libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
	libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
	libffi-dev liblzma-dev

curl https://pyenv.run | bash
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src

# configuring shell environment ~/.bashrc
# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
# echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
# echo 'eval "$(pyenv init -)"' >> ~/.bashrc

pyenv install 3.9.0
pyenv global 3.9.0

pip install opensearch-benchmark
opensearch-benchmark execute-test --pipeline=benchmark-only --workload=percolator --target-host=http://10.0.2.101:8080 --kill-running-processes
