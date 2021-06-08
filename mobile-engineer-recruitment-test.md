Dija - Mobile Engineer Recruitment Test
==================================

Thank you for taking the time to do our technical test. 🙂

This test is intended for mobile engineers (iOS/Android).

The challenge consists of two parts:

* [A coding test](#coding-test)
* A pairing session with a Dija engineer. We will add a small feature to your App


## Disclaimer
- Focus on what matters - for our recruitment process we want to focus on real use cases, rather than complex algorithms on a whiteboard.
- Done is better than perfect - we'd rather that you have lightweight solution that ticks most of the boxes than a perfect solution for one of them.
- Readability over performance - the code we write now will probably be rewritten many times. Let's make that easy for the next person!


# Coding Test
The test is to create an App that allows a **Store Manager** to access the incoming orders and see the list of items to be picked.

The application should display these information

**Orders in the list**
- `order_display_id`
- `created_at`
- `store_name`
- `number_of_items`
- `status` (`to_pick`, `picking`, `packed`, `completed`, `cancelled`)

**Order detail**
- `order_display_id`
- `created_at`
- `store_name`
- `delivery_notes`
- `status`
For each `line_items`
  - `quantity`
  - `shelf_mapping`
  - `name`
  - `image_url`
	

API sample responses
- List orders [GET /orders](fixtures/orders-list.json)
- Order detail [GET /orders/1945](fixtures/order-1945.json), [GET /orders/1944](fixtures/order-1944.json), [GET /orders/1943](fixtures/order-1943.json)

### User Story
As a Store Manager\
I can view the list of orders for a specific store\
So that I know which one needs to be prepared (to_pick)\
\
When I select an order\
I can view the order detail\
So that I know which items need to be picked


### Architecture
Feel free to use any architecture for the App. We will discuss your choice during our pairing session.

### Design
The App is an internal tool. So the design should be clean and functional. 🙂 

The app needs to follow this sample design system 
- [Figma](design/design-system.fig)
- [PDF](design/design-system.pdf)


### Task requirements
We believe this task shouldn't take more than a few hours, use your time wisely. ⏱

- Your code should compile and run in one step
- Feel free to use whatever frameworks / libraries / packages you like
- You **must** include tests
- Please avoid including artifacts from your local build; use a relevant `.gitignore`
- Please write a short post to describe the features you built. Imagine you need to share this content with non-technical people in the company. Keep it very short and please add it to `README.md` file.

## How to submit

- Just clone this repository 🧑‍💻
- Add your instructions to a markdown file **Test.md** 📝
- Share your private Github repository with tech-users@dijanow.com

Or simply send us a zip file.



#### Thanks for your time 🙏 we look forward to hearing from you! 🚀🚀

----

Inspiration for the test format taken with ❤️ from [JustEat's recruitment test](https://github.com/justeat/JustEat.RecruitmentTest).

