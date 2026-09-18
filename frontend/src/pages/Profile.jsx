import "../App.css";
import AppLayout from "../components/AppLayout";
import { useState } from "react";
import { Award, BarChart3, BookOpen, CalendarDays, CheckCircle2, Download, Edit3, GraduationCap, Mail, MapPin, Phone } from "lucide-react";

// Replace this object with the authenticated student's profile response.
const profileData = {
  identity: { initials: "AM", name: "Amina Mokoena", school: "University of Cape Town" },
  personal: {
    birthday: "12 March 2008",
    email: "amina.mokoena@student.uct.ac.za",
    phone: "+27 82 447 2180",
    location: "Cape Town, South Africa",
    documents: [
      { name: "Transcript.pdf", updated: "Updated 3 days ago", type: "PDF" },
      { name: "Motivation Letter.docx", updated: "Updated 1 week ago", type: "DOC" },
      { name: "ID Copy.jpg", updated: "Uploaded 2 weeks ago", type: "JPG" },
    ],
  },
  academic: {
    apsScore: 42,
    averageMark: 86,//if there is no function to cal mark then just remove i
    academicStanding: "Excellent standing",
    subjects: [
      { name: "Mathematics", mark: 88, level: "Level 7" },
      { name: "Physical Sciences", mark: 84, level: "Level 7" },
      { name: "English Home Language", mark: 82, level: "Level 6" },
      { name: "Computer Applications Technology", mark: 91, level: "Level 7" },
    ],
  },
};

const tabs = [
  { id: "personal", label: "Personal details", icon: BookOpen },
  { id: "academic", label: "Academic profile", icon: GraduationCap },
];

export default function Profile({ setPage }) {
  const [activeTab, setActiveTab] = useState("personal");
  const { identity, personal, academic } = profileData;

  return (
    <AppLayout setPage={setPage} activePage="profile">
      <div className="profile-page">
        <section className="profile-header card-panel">
          <div className="profile-identity">
            <div className="profile-photo">{identity.initials}</div>
            <div>
              <p className="eyebrow">Student profile</p>
              <h1>{identity.name}</h1>
              <div className="profile-meta-row">
                <span>{identity.school}</span>
              </div>
            </div>
          </div>

        
        </section>

        <div className="profile-tabs" role="tablist" aria-label="Profile sections">
          {tabs.map(({ id, label, icon: Icon }) => (
            <button key={id} type="button" role="tab" aria-selected={activeTab === id} className={`profile-tab ${activeTab === id ? "active" : ""}`} onClick={() => setActiveTab(id)}>
              <Icon size={16} />
              {label}
            </button>
          ))}
        </div>

        {activeTab === "personal" ? (
          <>
            <section className="profile-grid profile-personal-grid">
              <div className="card-panel profile-about">
                <div className="panel-head compact"><div><p className="eyebrow">About</p><h2>Personal details</h2></div></div>
                {personal.bio && <p className="profile-bio">{personal.bio}</p>}
                <div className="info-list">
                  <div className="info-item"><CalendarDays size={16} /><span>{personal.birthday}</span></div>
                  <div className="info-item"><Mail size={16} /><span>{personal.email}</span></div>
                  <div className="info-item"><Phone size={16} /><span>{personal.phone}</span></div>
                  <div className="info-item"><MapPin size={16} /><span>{personal.location}</span></div>
                </div>
              </div>
            </section>
            <section className="card-panel documents-panel">
              <div className="panel-head compact"><div><p className="eyebrow">Documents</p><h2>Submitted files</h2></div><button type="button" className="text-button"><Download size={15} />Upload new</button></div>
              <div className="document-list">
                {personal.documents.map(({ name, updated, type }) => <div key={name} className="document-item"><div className="document-name-wrap"><div className="document-icon">{type}</div><div><strong>{name}</strong><span>{updated}</span></div></div><button type="button" className="tiny-button">View</button></div>)}
              </div>
            </section>
          </>
        ) : (
          <section className="academic-profile">
            <section className="stats-grid profile-stats">
              <article className="stat-card blue"><div className="stat-icon"><Award size={18} /></div><div className="stat-info"><span>Average mark</span><strong>{academic.averageMark}%</strong><small>Across all subjects</small></div></article>
              <article className="stat-card green"><div className="stat-icon"><BarChart3 size={18} /></div><div className="stat-info"><span>APS score</span><strong>{academic.apsScore}</strong><small>Current total</small></div></article>
              <article className="stat-card gold"><div className="stat-icon"><CheckCircle2 size={18} /></div><div className="stat-info"><span>Academic standing</span><strong>{academic.academicStanding}</strong><small>Based on latest marks</small></div></article>
            </section>
            <section className="card-panel marks-panel">
              <div className="panel-head compact"><div><p className="eyebrow">Academic record</p><h2>Subject marks</h2></div><span className="marks-updated">Latest results</span></div>
              <div className="marks-list">
                {academic.subjects.map(({ name, mark, level }) => <div key={name} className="mark-row"><div className="mark-heading"><span>{name}</span><strong>{mark}% <small>{level}</small></strong></div><div className="mark-track"><span style={{ width: `${mark}%` }} /></div></div>)}
              </div>
            </section>
          </section>
        )}
      </div>
    </AppLayout>
  );
}
