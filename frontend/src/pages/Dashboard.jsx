import "../App.css";
import { ArrowRight, CalendarDays, CheckCircle2, ChevronRight, Clock3, Sparkles, Star, TrendingUp } from "lucide-react";
import AppLayout from "../components/AppLayout";

const stats = [
  { label: "Applications sent", value: "06", detail: "+2 this month", tone: "blue" },
  { label: "Offers received", value: "03", detail: "2 interviews", tone: "green" },
  { label: "Programmes saved", value: "12", detail: "3 shortlisted", tone: "gold" },
  { label: "Deadline alerts", value: "04", detail: "Next due in 5 days", tone: "purple" },
];

const shortlisted = [
  { name: "BSc Computer Science", school: "University of Cape Town", status: "Strong fit", tag: "Top choice" },
  { name: "BCom Finance", school: "Stellenbosch University", status: "Awaiting transcript", tag: "Priority" },
  { name: "BSc Data Analytics", school: "University of Witwatersrand", status: "Application in review", tag: "Reviewing" },
];

const reminders = [
  { title: "UCT application deadline", date: "Due in 5 days", type: "Academic" },
  { title: "Scholarship essay draft", date: "Submit by 18 Sep", type: "Funding" },
  { title: "Interview prep session", date: "Sat, 09:30", type: "Career" },
];

const scholarship = {
  title: "Merit Excellence Award",
  value: "R28,000",
  description: "Automatic review based on your current academic performance and leadership profile.",
};

export default function Dashboard({ setPage }) {
  return (
    <AppLayout setPage={setPage} activePage="dashboard" showTopBar>
      <div className="dashboard-page">
        <section className="header-row">
          <div>
            <p className="eyebrow">Overview</p>
            <h1>Welcome back, Amina</h1>
          </div>
          <button type="button" className="primary-button">
            Explore programmes
            <ArrowRight size={16} />
          </button>
        </section>

        <section className="stats-grid">
          {stats.map(({ label, value, detail, tone }) => (
            <article key={label} className={`stat-card ${tone}`}>
              <div className="stat-icon">
                {tone === "blue" && <TrendingUp size={18} />}
                {tone === "green" && <CheckCircle2 size={18} />}
                {tone === "gold" && <Star size={18} />}
                {tone === "purple" && <CalendarDays size={18} />}
              </div>
              <div className="stat-info">
                <span>{label}</span>
                <strong>{value}</strong>
                <small>{detail}</small>
              </div>
            </article>
          ))}
        </section>

        <section className="dashboard-grid">
          <div className="panel main-panel">
            <div className="panel-head">
              <div>
                <p className="eyebrow">Shortlist</p>
                <h2>Top programmes</h2>
              </div>
              <button type="button" className="text-button">
                View all <ChevronRight size={16} />
              </button>
            </div>

            <div className="programme-list">
              {shortlisted.map(({ name, school, status, tag }) => (
                <div key={name} className="programme-item">
                  <div className="programme-main">
                    <div className="programme-badge">{tag}</div>
                    <div>
                      <h3>{name}</h3>
                      <p>{school}</p>
                    </div>
                  </div>
                  <div className="programme-status">
                    <span>{status}</span>
                    <button type="button" className="tiny-button">Review</button>
                  </div>
                </div>
              ))}
            </div>
          </div>

          <aside className="panel side-panel">
            <div className="panel-head compact">
              <div>
                <p className="eyebrow">Next up</p>
                <h2>Reminders</h2>
              </div>
            </div>

            <div className="reminder-list">
              {reminders.map(({ title, date, type }) => (
                <div key={title} className="reminder-item">
                  <div className="reminder-icon">
                    <Clock3 size={15} />
                  </div>
                  <div>
                    <strong>{title}</strong>
                    <span>{date}</span>
                  </div>
                  <label>{type}</label>
                </div>
              ))}
            </div>
          </aside>
        </section>

        <section className="bottom-grid">
          <div className="panel scholarship-panel">
            <div className="panel-head compact">
              <div>
                <p className="eyebrow">Funding</p>
                <h2>Scholarships</h2>
              </div>
            </div>

            <div className="scholarship-content">
              <div className="scholarship-icon">
                <Sparkles size={18} />
              </div>
              <div>
                <h3>{scholarship.title}</h3>
                <strong>{scholarship.value}</strong>
                <p>{scholarship.description}</p>
              </div>
            </div>
          </div>

          <div className="panel performance-panel">
            <div className="panel-head compact">
              <div>
                <p className="eyebrow">Progress</p>
                <h2>Academic profile</h2>
              </div>
            </div>

            <div className="progress-stack">
              <div className="progress-row">
                <div className="progress-meta">
                  <span>Admission strength</span>
                  <strong>86%</strong>
                </div>
                <div className="progress-bar"><span style={{ width: "86%" }} /></div>
              </div>

              <div className="progress-row">
                <div className="progress-meta">
                  <span>Scholarship match</span>
                  <strong>74%</strong>
                </div>
                <div className="progress-bar"><span style={{ width: "74%" }} /></div>
              </div>

              <div className="progress-row">
                <div className="progress-meta">
                  <span>Careers fit</span>
                  <strong>91%</strong>
                </div>
                <div className="progress-bar"><span style={{ width: "91%" }} /></div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </AppLayout>
  );
}
