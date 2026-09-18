import { useState } from "react";
import { Check, ChevronRight, Search } from "lucide-react";
import "../App.css";
import AppLayout from "../components/AppLayout";
import { eligibilityFixture } from "../data/studentJourney";

export default function Eligibility({ setPage, eligibilityData = eligibilityFixture }) {
  const [programmeQuery, setProgrammeQuery] = useState("");
  const eligibleProgrammes = eligibilityData.recommendations.filter((programme) => programme.eligible !== false);
  const visibleProgrammes = eligibleProgrammes.filter((programme) => `${programme.name} ${programme.university}`.toLowerCase().includes(programmeQuery.toLowerCase()));

  return (
    <AppLayout setPage={setPage} activePage="eligibility">
      <div className="concept-page eligibility-concept-page">
        <section className="concept-heading"><div><p className="eyebrow">Academic fit</p><h1>Eligibility Checker</h1><p>See which programmes you qualify for based on your marks and APS.</p></div></section>
        <section className="concept-metric-grid">
          <article className="concept-metric-card"><span>Your current APS</span><strong>{eligibilityData.apsScore}</strong><small>Calculated from your marks</small></article>
          <article className="concept-metric-card"><span>Eligible programmes</span><strong>{eligibleProgrammes.length}</strong><small>Based on your current marks</small></article>
          <article className="concept-check-card"><div><p className="eyebrow">Check another programme</p><h2>Compare your results</h2></div><div className="concept-search"><Search size={14} /><input aria-label="Search programme" value={programmeQuery} onChange={(event) => setProgrammeQuery(event.target.value)} placeholder="e.g. Computer Science" /><button type="button" aria-label="Check programme"><Check size={15} /></button></div></article>
        </section>
        <section className="concept-table-panel card-panel eligibility-results-table">
          <div className="concept-panel-heading"><div><p className="eyebrow">Eligibility results</p><h2>Programmes matched to your profile</h2></div><button type="button" className="concept-link" onClick={() => setPage("programmes")}>View all programmes <ChevronRight size={13} /></button></div>
          <div className="concept-table-wrap"><table className="concept-table"><thead><tr><th>Programme</th><th>University</th><th>APS</th><th>Your APS</th><th>Status</th><th /></tr></thead><tbody>{visibleProgrammes.map((programme) => <tr key={programme.id}><td><div className="table-programme"><span className={`table-logo ${programme.tone}`}>{programme.initials}</span><strong>{programme.name}</strong></div></td><td>{programme.university}</td><td>{programme.aps}</td><td>{eligibilityData.apsScore}</td><td><span className="table-status eligible"><Check size={11} /> Eligible</span></td><td><button type="button" className="table-action" onClick={() => setPage("programme-details", programme)}><ChevronRight size={15} /></button></td></tr>)}</tbody></table></div>
          <div className="table-footer">Showing {visibleProgrammes.length} eligible programmes <button type="button"  >View all programmes <ChevronRight size={13} /></button></div>
        </section>
      </div>
    </AppLayout>
  );
}
