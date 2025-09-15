– AI Mood-Based Playlist & Storyteller

## 📌 Project Overview
MoodAI is an AI-powered application that generates **personalized stories, activity suggestions, and music recommendations** based on a user’s mood.  
It leverages **LangChain** for orchestration and **AWS Bedrock** for LLM access, combined with **Last.fm API** for music recommendations.

---

## ⚙️ Tech Stack
- **LangChain** → For chaining prompts and handling orchestration.
- **AWS Bedrock (Claude via LangChain)** → For generating creative stories and activity suggestions.
- **SQLite (SQLAlchemy ORM)** → For storing user mood history.
- **Streamlit** → For interactive web-based UI.
- **Last.fm API** → For mood & language-based music recommendations.

---

## 🛠️ Features Implemented

### 1. Mood Input
- User provides their current mood via a Streamlit text box.

### 2. Story & Activity Generation (LangChain + Bedrock)
- **LangChain PromptTemplate + LLMChain** used for:
  - Generating a **short creative story** reflecting the mood.
  - Suggesting **real-life activities** that match the mood.
- **SequentialChain** combines both steps so one input (`mood`) generates multiple outputs (`story`, `activity`).

### 3. Database (SQLite)
- **Schema:**
mood_id | date_time | mood_text | story_theme | activity_theme

markdown
Copy code
- Full story and activity are displayed immediately.
- A short theme (first sentence/moral) is stored in DB for quick history lookup.
- History view in the app shows the last 10 entries.

### 4. Music Recommendation (Last.fm API)
- Integrated **Last.fm free API** to fetch songs based on:
- User’s **mood**.
- Preferred **language/genre** (English, Hindi, Punjabi, Spanish, K-Pop, or Any).
- Display includes:
- Track name (with link to Last.fm).
- Artist.
- Listener count.
- Album art (fallback image if not available).

### 5. User Interface (Streamlit)
- Clean UI with:
- Mood input.
- Generated story & activity.
- Music recommendations.
- Sidebar with **mood history**.
- History entries show `date`, `mood`, `story_theme`, and `activity_theme`.

---

## 🚀 Current Status
- ✅ Mood journaling with database persistence.  
- ✅ Story & activity generation using **LangChain + AWS Bedrock**.  
- ✅ Music recommendations from **Last.fm API** with mood + language options.  
