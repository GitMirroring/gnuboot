% Libreboot 20140716 release
% Leah Rowe
% 16 July 2014

Revisions for r20140716 (2nd beta) (16th July 2014)
---------------------------------------------------

-   Deleted all git-related files from the coreboot directory. This was
    necessary because with those it is possible to run 'git diff'
    which shows the changes made in the form of a patch (diff format);
    this includes the blobs that were deleted during deblobbing.
