# Berlin Entdecken
#### Please view the HackMD docs in the links below to better view the images and Interactive Figma
[Figma](https://www.figma.com/design/z7uRpMMaKIRRTgl9Joaj4w/Berlin-Entdecken-App-?node-id=1-2&t=FoLnpb6OkPqO048f-1)
[App SPEC](https://hackmd.io/1y-gpvuoTB-hBzIh4KhXVQ)
[README](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A)


<a href="https://www.youtube.com/watch?v=XvoN4hqFTgw3DWP5">
  <img src="https://img.youtube.com/vi/XvoN4hqFTgw3DWP5/0.jpg" alt="Florencia Doval" width="480" height="360" border="10" />
</a>

## Table of Contents
1. [Overview](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Description)
2. [Product Spec](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Product-Spec)
3. [Wireframes](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Wireframes)
4. [Schema](https://hackmd.io/2V4h4Z_NTCOtHFWE5bcU_A#Schema)

## Overview :linked_paperclips: 

### Description
Berlin Entdecken is an app that combines both Travel and Education categories, helping tourists learn common German grammar rules and phrases needed in and around famous attractions in Berlin-Mitte. The app allows users to discover landmarks in Berlin while simultaneously learning practical German language skills, focusing on Nominativ, Akkusativ, and Dativ cases through interactive exercises tied to specific locations.

### App Evaluation :star: 
* **Category:** Travel & Education
* **Mobile:** Location-based learning experiences tied to Berlin landmarks; map integration for navigation; camera integration for scanning information plaques; push notifications for nearby attractions
* **Story:** Berlin attracts millions of tourists who often struggle with language barriers. This app provides contextual language learning tied to specific locations rather than generic phrases, making the tourist experience more immersive and educational.
* **Market:** Berlin attracts around 14 million tourists annually who struggle with language barriers. The app targets both language learners and travelers - a dual market. The niche value is in providing contextual language learning tied to specific locations, rather than generic phrases.
* **Habit:** Users would open the app multiple times daily during their Berlin trip - whenever they encounter a new landmark or need language assistance. Location-based triggers create natural usage patterns throughout a tourist's journey.
* **Scope:** The core functionality is clearly defined: location-based language lessons tied to Berlin attractions. A stripped-down MVP could focus on just Brandenburg Gate and Alexanderplatz areas with basic phrases, which would still demonstrate the concept effectively.

## Product Spec :iphone: 

### 1. User Stories (Required and Optional)

#### Required Must-have Stories
* User can view a map of Berlin highlighting major landmarks
* User can select a landmark to learn basic information about it in German and English
* User can practice German grammar (Nominativ, Akkusativ, Dativ) through exercises related to specific landmarks
* User can learn "Word of the Day" with contextual usage examples
* User can track their progress through different grammar exercises

#### Optional Nice-to-have Stories
* User can save favorite words/phrases to review later
* User can take a quiz based on previously learned content
* User can see pronunciation guides with audio for German phrases
* User can set daily learning goals and get reminders
* User can earn badges for completing exercises at different landmarks

### 2. Screen Archetypes

* **Map Screen (Main Page)**
  * User can view a map of Berlin highlighting major landmarks
  * User can select a landmark to learn more

* **Landmark Info Screen**
  * User can see information about the landmark in German and English
  * User can learn historical and cultural context

* **Practice Screen**
  * User can practice Nominativ, Akkusativ, and Dativ cases
  * User can complete grammar exercises related to the landmark

* **Daily Challenge Screen**
  * User can practice daily exercises to reinforce learning
  * User can learn the "Word of the Day"

* **Saved Words/Profile Screen**
  * User can review saved words and phrases
  * User can track progress and achievements

### 3. Navigation :airplane_departure: 

#### Tab Navigation (Tab to Screen)
* Map/Home
* Practice
* Daily Challenge
* Saved Words/Profile

#### Flow Navigation (Screen to Screen)
* **Map Screen**
  * => Info Page (when selecting a landmark)
  
* **Info Page**
  * => Back to Map
  * => Practice Page (for related grammar exercises)
  
* **Practice Page**
  * => Back to Info Page
  * => Results/Completion Page

* **Daily Challenge**
  * => Practice specific grammar type
  * => Word of the Day details

* **Saved Words/Profile**
  * => Word details
  * => Practice related words

## Wireframes :frame_with_picture: 
![Screenshot 2025-04-21 at 11.44.57 PM](https://hackmd.io/_uploads/r10ReqEkxe.png)
![Screenshot 2025-04-21 at 11.45.05 PM](https://hackmd.io/_uploads/rkRCxqEJel.png)
![Screenshot 2025-04-21 at 11.45.10 PM](https://hackmd.io/_uploads/S10Re9Eygl.png)

### Digital Wireframes & Mockups
The Figma design shows a comprehensive set of screens including Main Page with map, Info Pages for landmarks, Practice Pages for grammar, and Saved Words/Profile sections.

### [Interactive Prototype](https://www.figma.com/proto/z7uRpMMaKIRRTgl9Joaj4w/Berlin-Entdecken-App-?node-id=0-1&t=DgYoT8VIJAq1Cy9d-1)

<iframe
        style={{ border: "rgba(0, 0, 0, 0)", background: "rgba(0, 0, 0, 0)" }}
        width="700"
        height="650"
        flex-direction="row"
        align-items="center"
        background="rgba(0, 0, 0, 0)"
        src="https://embed.figma.com/proto/z7uRpMMaKIRRTgl9Joaj4w/Berlin-Entdecken-App-?node-id=1-2&p=f&scaling=scale-down&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=1%3A2&embed-host=share"
        allowFullScreen
      ></iframe>
      


# SPRINTS:

### Step 1: Identify Main Features
**Map View** with Fun Facts or informaiton about the sight in Berlin clicked by the User. (MVP)
**Practice Mode** Here the user is able to practice the german cases(nominativ, Akkusativ, Dativ) with information about the sights in Berlin. The user can click from the option of right answers and receive feedback and explanations about their response.
**Library** here the user can save new learned words
**Daily Challenge** Here, I want to suggest the user challenges in the city and to try to use common phrases. For example, at a restaurant.
**Word of the Day** I'm hoping to use a German Dictionary API to suggest new words for the user to learn daily.
**User Profile** Here the user could be able to see their progress [but this will be a stretch feature, not an MVP]

### Step 2: Breakdown into Sprints
Sprint 1: MVP Done
- [x] Finish Interactive Figma Design
- [x] Add a map container
- [x] Finish all ViewControllers in the Storyboard (TabController, icons, sizes, and constrains)
- [x] Gather all information (German Cases grammar, information and images of the sights in Berlin).
- [x] Add all the logic for clicking and seeing the sights in the Map
- [x] Implement the Practice Mode logic (sentences, explanation of the grammar point, feedback, and image with the conjugation)
- [x] Add constraints for screen responsiveness

Sprint 2: Extra Features + Improvements
- [ ] Implement the Library section
- [ ] Implement an API call for the Word of The Day Logic and connecting it to the main app
- [ ] Implement the Daily Challenge with the most common phrases in german
- [ ] Add a User Profile Section

