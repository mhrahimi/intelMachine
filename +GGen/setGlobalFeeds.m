function setGlobalFeeds(feed)

% constants
multiplier = 1.6;

global cuttingFeed
global fastFeed
global slowFeed
global superSlowFeed
global superFastFeed
global precautionFeed
global crazyFeed
global hundredFeed

cuttingFeed = feed;

fastFeed = floor(cuttingFeed * multiplier);
superFastFeed = floor(cuttingFeed * (multiplier^2));
crazyFeed = 10000;

slowFeed = floor(cuttingFeed / multiplier);
superSlowFeed = floor(cuttingFeed / (multiplier^2));
precautionFeed = 50;

hundredFeed = 100;

