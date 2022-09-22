# AuctionMe

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
We aim to create a next-gen dating application that revolutionises the online dating scenario for Gen-z. Our dating app will add the feature of ‘auctioning’ your friends/family on the app, as a fun social component.

### App Evaluation
- **Category:** Social Networking 
- **Mobile:** This app would be primarily developed for mobile and could have a desktop component similar to many other social networking apps.
- **Story:** Allow individuals to post profiles for a friend or family member.  The profile can then be view by other users and then people can bid with points to get a chance to go on a date with that person.
- **Market:** This app could be used by anyone over 18 with an emphasis placed on college students.
- **Habit:** This app will be used in accordance with what the user sees fit with respect to their relationship status and interest in dating.
- **Scope:** The first interation of the app would focus mainly on college students and particularly with Penn State students.  It could potentially scale at somepoint to a nationwide or worldwide app experience.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User logs in to access previous chats and preference settings
- [x] User can view posts from other users with dating profiles.
- [ ] User can like or dislike a post to show interest
- [ ] User can utilize a private chat feature to communicate with others
- [ ] Settings (Accesibility, Notification, General, etc.)

**Optional Nice-to-have Stories**

- [ ] Most Favorite meme

### 2. Screen Archetypes

* Login 
* Register - User signs up or logs into their account
   * If not already logged in with an existing account, this screen will prompt the user to create an account to track posts and messages.
* Local Post Feed - View posts from other users
   * This screen will show posts made by otehr users containing auctions for other users
   * If interested the user can place a bid inorder to communicate with the person
* Profile Screen 
   * View what posts others have made about you
   * View posts you have made about others 
* Chat Messaging Screen
   * Show chat requests and messages from other users
   * Securely and privately exchange messages with other users
* Settings Screen
   * Lets people change language, and app notification settings.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed/Posts
* Chats
* Profile
* Settings

**Flow Navigation** (Screen to Screen)
* Forced Log-in -> Account creation if no log in is available
* Select post -> Jump to large view post
* Like a post -> Jump to chat with the other user
* Profile -> Shows users own profile with option to edit
* Settings -> Toggle settings

## Wireframes
<img src="https://i.imgur.com/322aI2E.jpg" width=800><br>

## Schema
**Posts**
| Property | Type | Description |
| --- | --- | --- |
| name | String | Name of person being posted|
| age | Number | Age of person being posted |
| location | String | location of the person |
| interests | String | description of interests |
| pros+cons | String | description of pros and cons of person |
| images | File | images of person being posted about |
| liked | Boolean | field to show if a post is liked or not |
| instagram | String | instagram link |
| facebook | String | facebook link|

**Users**
| Property | Type | Description |
| --- | --- | --- |
| username | String | Name of person being posted|
| age | Number | Age of person being posted |
| location | String | description of interests |
| password | String | description of pros and cons of person |

### App Walkthrough GIF

<img src="http://g.recordit.co/yFIGxnAqVy.gif" width=250><br>
