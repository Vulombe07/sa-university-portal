import { useMemo, useState } from "react";
import { CheckCircle2, ChevronRight, Clock3 } from "lucide-react";
import "../App.css";
import AppLayout from "../components/AppLayout";
import { applicationsFixture } from "../data/studentJourney";

const tabs = ["all", "in-progress", "submitted"];

function isSubmitted(application) {
  return application.statusTone === "success" || application.status.toLowerCase().includes("submitted") || application.status.toLowerCase().includes("offer");
}

export default function Applications({ setPage, applicationsData = applicationsFixture }) {
  const [activeTab, setActiveTab] = useState("all");
  const tabCounts = useMemo(() => ({
    all: applicationsData.length,
    "in-progress": applicationsData.filter((application) => !isSubmitted(application)).length,
    submitted: applicationsData.filter(isSubmitted).length,
  }), [applicationsData]);
  const visibleApplications = useMemo(() => {
    if (activeTab === "submitted") return applicationsData.filter(isSubmitted);
    if (activeTab === "in-progress") return applicationsData.filter((application) => !isSubmitted(application));
    return applicationsData;
  }, [activeTab, applicationsData]);

  return (
    <AppLayout setPage={setPage} activePage="applications">
      <div className="concept-page applications-concept-page">
        <section className="concept-heading"><div><p className="eyebrow">Your university applications</p><h1>My Applications</h1><p>Track the status of all your university applications.</p></div><button type="button" className="primary-button" onClick={() => setPage("programmes")}>Apply to a programme <ChevronRight size={15} /></button></section>
        <section className="concept-table-panel card-panel">
          <div className="concept-panel-heading"><div><p className="eyebrow">Application dashboard</p><h2>Your applications</h2></div><span className="concept-record-count">{visibleApplications.length} applications shown</span></div>
          <div className="concept-tabs">{tabs.map((tab) => <button type="button" key={tab} className={activeTab === tab ? "active" : ""} onClick={() => setActiveTab(tab)}>{tab === "all" ? "All" : tab === "in-progress" ? "In progress" : "Submitted"} ({tabCounts[tab]})</button>)}</div>
          <div className="concept-table-wrap"><table className="concept-table applications-table"><thead><tr><th>Programme</th><th>University</th><th>Status</th><th>Last updated</th><th /></tr></thead><tbody>{visibleApplications.length > 0 ? visibleApplications.map((application) => <tr key={application.id}><td><div className="table-programme"><span className={`table-logo ${application.tone}`}>{application.initials}</span><strong>{application.programme}</strong></div></td><td>{application.institution}</td><td><span className={`table-status ${application.statusTone}`}>{isSubmitted(application) ? <CheckCircle2 size={11} /> : <Clock3 size={11} />}{application.status}</span></td><td>{application.submitted}</td><td><button type="button" className="table-action" onClick={() => setPage("programme-details")}><ChevronRight size={15} /></button></td></tr>) : <tr><td colSpan="5" className="applications-empty-state">No applications in this category yet.</td></tr>}</tbody></table></div>
          <div className="table-footer">Showing {visibleApplications.length} applications</div>
        </section>
      </div>
    </AppLayout>
  );
}
