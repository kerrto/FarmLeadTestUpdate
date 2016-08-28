This was a test for FarmLead. 

Here's what I did:

I created a splash page. I edited the storyboard in Any/Any and Compact/Regular to adjust to different sized screens.

I wrote a check in viewDidLoad to see if it's a retina display and to display the bigger image if it is.

I used the AlamoFire to download the commodity unit list from the API and cached it using NSCache. I created a shared instance as a singleton to be shared with other viewControllers.

I had the onboarding pages load after a delay so the user would have time to see the beautiful picture.

I used a UIPageViewController to control the page navigation.

I had a modal view pop up after the user had swiped to the last page. This is where the user settings are set.

I made an API call with Alamofire after the user typed two letters into the citytextfield. I set up an NSNotification to detect when two letters are written. This also calls the cities picker table.

I included a Popover cocoapod in the project because it was a pain implementing the tableviews and this solution looked elegant and customizable.

The tableView rows that are picked change the label/texField values.

When the user selects OKAY, the ids are stored in NSUserDefaults.

I set the size class views so it would look good on an ipad.

