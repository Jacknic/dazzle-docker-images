sudo /usr/bin/buildkitd --debug  --config ./buildkitd.toml &
mkdir -p /workspace/registry &
docker run -p 5000:5000 --name registry --rm -v /workspace/registry:/var/lib/registry registry:2 &