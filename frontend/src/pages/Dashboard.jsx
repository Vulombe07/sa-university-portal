import "../App.css";
import { ArrowRight, CheckCircle2, ChevronRight, CircleCheck, Compass, FileText, Search, Sparkles, Star } from "lucide-react";
import AppLayout from "../components/AppLayout";
import { dashboardFixture } from "../data/studentJourney";

const metricIcons = { score: Star, eligible: CircleCheck, applications: FileText };

function ProgrammeLogo({ initials, tone }) {
  return <span className={`dashboard-reference-logo ${tone}`}>{initials}</span>;
}

export default function Dashboard({ setPage, dashboardData = dashboardFixture }) {
  const { student, metrics, recommendedProgrammes } = dashboardData;

  return (
    <AppLayout setPage={setPage} activePage="dashboard" showTopBar>
      <div className="dashboard-reference-page">
        <section className="dashboard-reference-welcome">
          <div><p className="eyebrow">Welcome back, {student.firstName} <span aria-hidden="true">👋</span></p><h1>Here&apos;s a quick overview of your university journey.</h1></div>
          <button type="button" className="dashboard-explore-button" onClick={() => setPage("programmes")}><Compass size={20} /> Explore programmes <ArrowRight size={16} /></button>
        </section>

        <section className="dashboard-reference-metrics">
          {metrics.map((metric) => { const Icon = metricIcons[metric.icon] || Star; return <article className={`dashboard-reference-metric ${metric.tone}`} key={metric.label}><div className="dashboard-reference-metric-icon"><Icon size={20} /></div><div><span>{metric.label}</span><strong>{metric.value}</strong><small>{metric.detail}</small><button type="button" onClick={() => setPage(metric.icon === "score" ? "profile" : "applications")}>{metric.icon === "score" ? "View details" : "View applications"} <ArrowRight size={13} /></button></div></article>; })}
        </section>

        <section className="dashboard-reference-section-heading"><div><h2>Recommended Programmes</h2><p>Based on your profile and APS score. You are eligible for:</p></div><button type="button" className="text-button" onClick={() => setPage("eligibility")}>View all <ArrowRight size={14} /></button></section>

        <section className="dashboard-reference-programmes">
          {recommendedProgrammes.map((programme) => <article className="dashboard-reference-programme" key={programme.id}><ProgrammeLogo initials={programme.initials} tone={programme.tone} /><div><strong>{programme.university}</strong><h3>{programme.name}</h3><p>APS: {programme.aps} <span /> Maths: {programme.maths}</p><span className="dashboard-reference-eligible"><CheckCircle2 size={12} /> Eligible</span></div><button type="button" className="primary-button" onClick={() => setPage("programme-details", programme)}>Apply</button></article>)}
        </section>
      </div>
    </AppLayout>
  );
}