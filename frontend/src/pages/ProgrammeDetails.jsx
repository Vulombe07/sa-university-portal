import {
	ArrowLeft,
	ArrowRight,
	BookOpen,
	CalendarDays,
	CheckCircle2,
	Clock3,
	FileText,
	MapPin,
	Send,
} from "lucide-react";
import "../App.css";
import AppLayout from "../components/AppLayout";
import { programmes } from "../data/programmes";

function ProgrammeLogo({ initials, tone }) {
	return <div className={`details-programme-logo ${tone}`}>{initials}</div>;
}

export default function ProgrammeDetails({ programme, setPage }) {
	const selectedProgramme = programme || programmes[0];

	return (
		<AppLayout setPage={setPage} activePage="programmes" showTopBar={false}>
			<div className="programme-details-page">
				<button type="button" className="back-to-search" onClick={() => setPage("programmes")}>
					<ArrowLeft size={15} /> Back to search
				</button>

				<section className="programme-details-hero">
					<div className="details-hero-main">
						<ProgrammeLogo initials={selectedProgramme.initials} tone={selectedProgramme.tone} />
						<div>
							<div className="details-breadcrumb">Undergraduate <span>/</span> {selectedProgramme.faculty}</div>
							<h1>{selectedProgramme.name}</h1>
							<p className="details-university">{selectedProgramme.university}</p>
							<div className="details-location"><MapPin size={14} /> {selectedProgramme.location}</div>
						</div>
					</div>
					<div className="details-hero-actions">
						<span className={`eligibility-badge ${selectedProgramme.eligible ? "eligible" : "review"}`}>
							{selectedProgramme.eligible && <CheckCircle2 size={13} />}
							{selectedProgramme.eligible ? "You are eligible" : "Review requirements"}
						</span>
						<button type="button" className="primary-button apply-button"><Send size={15} /> Apply now</button>
					</div>
				</section>

				<section className="details-stat-strip">
					<div><span>APS requirement</span><strong>{selectedProgramme.aps}</strong></div>
					<div><span>Mathematics</span><strong>{selectedProgramme.maths}</strong></div>
					<div><span>Duration</span><strong>{selectedProgramme.duration}</strong></div>
					<div><span>Study mode</span><strong>{selectedProgramme.mode}</strong></div>
				</section>

				<div className="programme-details-grid">
					<main className="details-content-column">
						<section className="details-panel details-overview-panel">
							<div className="details-panel-heading"><BookOpen size={17} /><div><p className="eyebrow">Programme overview</p><h2>Shape your future in technology</h2></div></div>
							<p>{selectedProgramme.description}</p>
							<p>{selectedProgramme.overview}</p>
						</section>

						<section className="details-panel">
							<div className="details-panel-heading"><CheckCircle2 size={17} /><div><p className="eyebrow">Entry requirements</p><h2>What you need to apply</h2></div></div>
							<div className="requirement-list">
								{selectedProgramme.requirements.map((requirement) => <div key={requirement}><CheckCircle2 size={15} /> <span>{requirement}</span></div>)}
							</div>
						</section>

						<section className="details-panel">
							<div className="details-panel-heading"><FileText size={17} /><div><p className="eyebrow">What you will study</p><h2>Core subjects</h2></div></div>
							<div className="subject-chip-list">{selectedProgramme.subjects.map((subject) => <span key={subject}>{subject}</span>)}</div>
						</section>
					</main>

					<aside className="details-side-column">
						<section className="details-apply-card">
							<div className="details-apply-card-top"><CalendarDays size={18} /><span>Applications open</span></div>
							<h2>Ready to take the next step?</h2>
							<p>Use your UniApply profile to submit a complete application in one place.</p>
							<button type="button" className="primary-button apply-card-button">Start application <ArrowRight size={15} /></button>
							<small>Applications close {selectedProgramme.closingDate}</small>
						</section>
						<section className="details-panel details-facts-panel">
							<p className="eyebrow">At a glance</p>
							<div><Clock3 size={15} /><span>Full-time study</span></div>
							<div><MapPin size={15} /><span>{selectedProgramme.location}</span></div>
							<div><BookOpen size={15} /><span>{selectedProgramme.faculty}</span></div>
						</section>
					</aside>
				</div>
			</div>
		</AppLayout>
	);
}
