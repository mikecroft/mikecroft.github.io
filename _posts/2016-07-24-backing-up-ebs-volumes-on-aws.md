---
layout: post
title: Backing up EBS Volumes on AWS
comments: true
tags: 
  - AWS
  - python
  - ebs
---

This is post is a long time coming. Not so long after I first joined C2B2, I had the job of making sure that our internal production servers were properly backed up. It was a pretty important job, but the sort where a young, new starter could be let loose without doing any damage, since the only real problem you can run into is accidentally taking too many backups. If you accidentally delete all the snapshots you've been taking to prevent that issue, well, you're back where you started and nothing has really changed.

I chose to use Python because I hadn't used it before and it's pretty easy to work with. The version 1 of my script was a single file and not particularly well written. It was put together to work, not to be pretty, maintainable, or easily modifiable.

Fast-forward a year or two and I needed a small "real" project to help me learn Git. I'd had the idea of refactoring this script in the back of my mind for a long time, so it seemed a good candidate.

The updated script is somewhat self explanatory, the main file which does all the work being [`EC2VolumeSnapshotter.py`](https://github.com/mikecroft/EC2VolumeSnapshotter/blob/master/EC2VolumeSnapshotter.py) which gets called by `EC2Runner.py`.

Despite being pretty sure there are lots of ways to make my new script better, I still managed to find a lot of facepalm moments. The one that really sticks in my mind is when I created what is now a method to find the earliest snapshot so that it can be deleted and the number of snapshots are kept under control - cunningly named [`findEarliest`](https://github.com/mikecroft/EC2VolumeSnapshotter/blob/master/EC2VolumeSnapshotter.py#L133).

The original section of code had an extended section involving comparing each string in the array. While reviewing the code to make sure I understood properly what on earth I was thinking about those years ago, it struck me that what I was doing was a fairly common problem - "find the earliest date". After a quick google and review of StackOverflow, I found that I could replace it all with the `min()` function, as you can see:

``` python
    def findEarliest(self, snapshots):
        ''' Given a list of snapshot IDs and
            their timestamps, finds the oldest
            and returns the ID of the snapshot
        '''
        dates = []
        for snap in snapshots:
            dates.append(snap[1])

        for snap in snapshots:
            if (snap[1] == min(dates)):
                ss = snap [0]
        self.logger.info("The earliest snapshot is: " + ss)
        return ss
```

&nbsp;  
All in all, despite the horror at my amateurish first efforts, refactoring such a small, self-contained project was very satisfying. It's nice to have an achievable goal and be able to do things properly without worrying about deadlines. I hope to revisit it again soon, for version 3, and address some of the other shortcomings I've found about it.

Any suggestions on how I can improve what I've got are very welcome!
