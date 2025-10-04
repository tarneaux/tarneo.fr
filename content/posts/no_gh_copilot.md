---
title: "Two months without GitHub Copilot"
date: 2024-06-16
summary: "The AI bubble can pop, I'll sleep"
---

I have already [written about the ethics of GitHub Copilot](/posts/github_copilot/) before. On April 7th, I completely removed it from my NeoVim configuration, and it has stayed out it since then.

The first thing I noticed was what some people call the "Copilot pause": even when I knew exactly what I wanted to write, I stopped typing to wait for the LLM to complete what I was writing anyway. That was gone after about half an hour of programming though, and it only came back for one or two days when starting to edit code again after having stopped for some time.

The first two or three days felt a bit strange: I had to look up documentation for what I was doing all the time. Since I had also stopped using the CLI version of Copilot, which I used extensively before to write text mangling scripts, I also had to look up how to do basic things in Bash that I never bothered learning until then. For example, I was constantly asking Copilot how to get a part of a regexp for each line of stdin, and finally had to learn it.

I also couldn't just guess some things and get Copilot to complete them (remember: LLMs are "garbage in, garbage out"). I really had to look up the documentation. Now that I think about it, it actually was faster _even initially_, since guessing things to get Copilot to complete takes a few tries before your code works (or compiles if you're doing rust, like I am). Having to think about an implementation also made me more conscious of the decisions I took instead of just following what the LLM suggested me to do.

To me, the only downside of stopping to use Copilot is not being able to write boilerplate as fast as before, but I think that also makes me think more about whether or not I really need the boilerplate or if I can find a DRY solution. If not, it still helps me to think about the boilerplate as mentioned above (if there's something to think about).

The last practical benefit is not having to be constantly connected to the internet: I can now just code for long periods of time without any internet connection, and I don't get annoyed because of the "Copilot pause" anymore (You may say that I still have to look up documentation, but that's not really a problem with Rust's locally runnable documentation).

Apart from the practical benefits, it's just good to not depend on a mega corporation (Microsoft owning both OpenAI and GitHub) just to do something as basic (for me) as writing code. I'm finally back to being totally independent from Microsoft (apart from GitHub, but they can delete my account anytime they want because I run [Gitea](https://about.gitea.com/) and have all my repos mirrored there).

I have also totally stopped using all kinds of LLMs: my OpenAI account is permanently deleted and I won't recreate one, and I have never used any other LLM.

When the AI bubble pops, I won't even notice it.
