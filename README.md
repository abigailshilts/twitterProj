# Project 2 - *TwitterDemo*

**TwitterDemo** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **24** hours spent in total

## User Stories

The following **core** features are completed:

**A user should**

- [✅] See an app icon in the home screen and a styled launch screen
- [✅] Be able to log in using their Twitter account
- [✅] See at latest the latest 20 tweets for a Twitter account in a Table View
- [✅] Be able to refresh data by pulling down on the Table View
- [✅] Be able to like and retweet from their Timeline view
- [✅] Only be able to access content if logged in
- [✅] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [✅] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [✅] See Tweet details in a Details view
- [✅] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **stretch** features are implemented:

**A user could**

- [✅] Be able to **unlike** or **un-retweet** by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [✅] See a character count when composing a Tweet (as well as a warning) (280 characters) (**1 point**)
- [✅] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client

The following **additional** features are implemented:

- Retweet reposts the tweet to the timeline

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. My unretweet is a little buggy un respects to removing the secondary post of the tweet to the timeline, so I would like to explore that further
2. I would like it if delegates could be expanded on further

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![twitterVidP1](https://user-images.githubusercontent.com/58635711/175428767-95016f41-d0b7-4d27-b7ea-84c1758cfd08.gif)
![twitterVidP2](https://user-images.githubusercontent.com/58635711/175429629-b40e48ea-8e27-4ea9-bfc7-f8f2cb093c53.gif)
![twitterVidP3](https://user-images.githubusercontent.com/58635711/175429734-e84a82a1-eae1-417f-b866-360aa8b47605.gif)
![twitterVidP4](https://user-images.githubusercontent.com/58635711/175429924-19ac66e6-087e-4514-9a88-6cdb03433556.gif)
![twitterVidp5](https://user-images.githubusercontent.com/58635711/175429983-629f1751-5bce-4899-8ea5-34e7a3273623.gif)
![twitterVidP6)](https://user-images.githubusercontent.com/58635711/175719135-aef92069-fbb2-4568-a27a-a90e29aed42f.gif)

GIF in parts to meet GitHub size requirement, if there is an issue with any part or to see full version see recordingP2Twitter.mov in the main branch of the repo

GIF created with [EZGif](https://ezgif.com/).

## Notes

One of the biggest challenges I've had with this app is using delegates. I feel like I don't have a great grasp of them but by the end of the project was able to folloe other examples in the code when I needed them. Aside from that I think this project has helped me get a much better understanding of models and tableviews.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools)

## License

    Copyright [2022] [Abigail Shilts]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
