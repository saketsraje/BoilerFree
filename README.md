# BoilerFree

A web-based application which helps Purdue University students discover any upcoming campus events offering free food, merchandise, and/or other perks.

## The Problem

Purdue students frequently fail to take advantage of the available opportunities to enjoy free meals, freebies, and other benefits on campus since finding out about such events involves manually going through BoilerLink. While BoilerLink offers the necessary information on events and perk filters, there is no easy way for students to monitor any new postings without constantly visiting the website.

BoilerFree seeks to change that by gathering all necessary events in one place automatically.

## How It Works

BoilerFree will automatically retrieve upcoming Purdue University events from BoilerLink and identify those offering free food or merchandise.

My Minimum Viable Product (MVP) will include:

1. **Event Retrieval:** Use Bash, `curl` to retrieve upcoming events from BoilerLink.
2. **Event Processing:** Use Python to filter events offering free food or merchandise and sort those results in chronological order.
3. **Event Storage:** Store event information in SQLite Database (native for Python3) to prevent duplicates and identify newly discovered events.
4. **Web Interface:** Use Flask, HTML, and CSS to display event names, dates, times, locations, perks, and links to their original BoilerLink listings.
5. **Event Filtering:** Allow students to filter events by free food, merchandise, or both, while highlighting newly discovered opportunities.

A scheduled `cron` job will periodically update the stored event information.

### System Architecture

![BoilerFree System Architecture](docs/System%20Architecture%20-%20CS193%20Project.drawio.png)

The system consists of two main processes: automated event collection using Bash and Python, and a student-facing Flask web interface connected through a shared SQLite database.

## Tech Stack

1. **Main Programming Languages:** Python, Bash, HTML and CSS.
2. **Bash Utilities:** `curl`, `jq`, and `cron`
3. **Python Libraries:** Flask, `sqlite3`, `json`, `datetime`, `zoneinfo`, and `argparse`.
4. **Data Storage:** SQLite
5. **External Data Source (API):** https://boilerlink.purdue.edu/api/discovery/event/search
6. **Frontend:** Flask, HTML and CSS. 
7. **Version Control:** Git and GitHub.

## Setup

**Status: Under Development**

The following instructions cover the initial project setup. Instructions for launching the completed application will be added during development.

**Prerequisites:**
- Python 3
- Git
- Bash
- `curl` and `jq`
- Flask (installed through `requirements.txt`)

**Clone the repository:**

```bash
git clone https://github.com/saketsraje/BoilerFree.git
cd BoilerFree
```

**Create and activate a Python virtual environment (macOS/Linux):**

```bash
python3 -m venv .venv
source .venv/bin/activate
```

**Install Python dependencies:**

```bash
python3 -m pip install -r requirements.txt
```

Follow these steps to setup the Python environment.
The remaining program will be deployable once ready. That information will be updated here later. 

## Usage

**Status: Not Yet Implemented**

Once developed, students will be able to open the BoilerFree application in their web browser and:

1. View upcoming campus events offering free food or merchandise.
2. Filter events by their preferred perk category.
3. See event dates, times, locations, and available perks.
4. Identify newly discovered events.
5. Open the original BoilerLink listings for additional information.

The application will retrieve updated event information periodically using a scheduled Bash script.

Instructions for starting the Flask server and accessing the application locally will be added once the MVP is functional.

## Roadmap

The following features are planned for future versions after the MVP is complete:

- [ ] Send automated email or desktop notifications for newly listed events.
- [ ] Show nearby events using campus building locations or walking distance
- [ ] Accept student-submitted Instagram event links with verification.
- [ ] Detect changes to event times, locations, or cancellations.
- [ ] Improve the overall UI and simplicity of the website with personalised notifications and other future functionality.
 
## Author

**Saket Sachin Raje**

GitHub: https://github.com/saketsraje
