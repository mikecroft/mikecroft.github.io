---
layout: post
title:  "First Post!"
date:   2014-06-26 21:39:10
categories: jekyll update
---

This is my new blog

Here's a Python code snippet:

{% highlight python %}

	def createSnapshot(self, vol_name):
		''' Uses ec2addsnap to create a snapshot from
			the given volume name
		'''
		addSnap = subprocess.Popen(
			['ec2addsnap', '--region', self.region, vol_name],
			stdout=subprocess.PIPE, stderr=subprocess.PIPE)
		out, err = addSnap.communicate()
		out = out.strip().decode('utf-8')
		err = err.strip().decode('utf-8')

		if (err == ""):
			self.logger.info("Created snapshot:\n" + out)
			return True
		self.logger.error("Could not create snapshot. AWS returned stderr: " + err)
		return False

{% endhighlight %}