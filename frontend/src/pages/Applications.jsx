import { ChevronRight, FileCheck2, UploadCloud } from "lucide-react";
import "../App.css";
import AppLayout from "../components/AppLayout";
import { applicationsFixture } from "../data/studentJourney";

const tabs = ["All (4)", "In Progress (2)", "Submitted (1)", "Documents Required (1)"];

export default function Applications({ setPage, applicationsData = applicationsFixture }) {
  return (
    <AppLayout setPage={setPage} activePage="applications">
      <div className="concept-page applications-concept-page">
        <section className="concept-heading"><div><p className="eyebrow">Your university applications</p><h1>My Applications</h1><p>Track the status of all your university applications.</p></div><button type="button" className="primary-button" onClick={() => setPage("programmes")}>Apply to a programme <ChevronRight size={15} /></button></section>
        <section className="concept-table-panel card-panel">
          <div className="concept-panel-heading"><div><p className="eyebrow">Application dashboard</p><h2>Your applications</h2></div><span className="concept-record-count">{applicationsData.length} active records</span></div>
          <div className="concept-tabs">{tabs.map((tab, index) => <button type="button" key={tab} className={index === 0 ? "active" : ""}>{tab}</button>)}</div>
          <div className="concept-table-wrap"><table className="concept-table applications-table"><thead><tr><th>Programme</th><th>University</th><th>Status</th><th>Last updated</th><th /></tr></thead><tbody>{applicationsData.map((application) => <tr key={application.id}><td><div className="table-programme"><span className={`table-logo ${application.tone}`}>{application.initials}</span><strong>{application.programme}</strong></div></td><td>{application.institution}</td><td><span className={`table-status ${application.statusTone}`}>{application.statusTone === "action" ? <UploadCloud size={11} /> : <FileCheck2 size={11} />}{application.status}</span></td><td>{application.submitted}</td><td><button type="button" className="table-action" onClick={() => setPage("programme-details")}><ChevronRight size={15} /></button></td></tr>)}</tbody></table></div>
          <div className="table-footer">Showing {applicationsData.length} applications <button type="button" className="concept-link" onClick={() => setPage("programmes")}>Apply to another programme <ChevronRight size={13} /></button></div>
        </section>
      </div>
    </AppLayout>
  );
}
