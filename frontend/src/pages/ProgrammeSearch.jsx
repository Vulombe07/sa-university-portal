import { useMemo, useState } from "react";
import {
	ArrowRight,
	Bookmark,
	CheckCircle2,
	ChevronDown,
	Clock3,
	MapPin,
	Search,
	SlidersHorizontal,
} from "lucide-react";
import "../App.css";
import AppLayout from "../components/AppLayout";
import { programmes } from "../data/programmes";

const popularSearches = ["Computer Science", "Engineering", "Medicine", "Law", "Commerce", "Psychology", "Architecture", "Data Science"];
const facultyOptions = ["All faculties", "Humanities", "Science", "Engineering & Built Environment", "Health Sciences", "Commerce"];
const facultyAliases = {
	Humanities: ["humanities", "arts"],
	Science: ["science"],
	"Engineering & Built Environment": ["engineering", "built environment"],
	"Health Sciences": ["health science", "health sciences", "medicine"],
	Commerce: ["commerce", "economic", "management sciences", "business"],
};

function ProgrammeLogo({ initials, tone }) {
	return <div className={`search-programme-logo ${tone}`}>{initials}</div>;
}

export default function ProgrammeSearch({ setPage }) {
	const [query, setQuery] = useState("Computer Science");
	const [faculty, setFaculty] = useState("All faculties");
	
	const visibleProgrammes = useMemo(() => {
		const normalizedQuery = query.trim().toLowerCase();

		return programmes.filter((programme) => {
			const matchesQuery = !normalizedQuery || `${programme.name} ${programme.university} ${programme.faculty}`.toLowerCase().includes(normalizedQuery);
			const normalizedFaculty = programme.faculty.toLowerCase();
			const matchesFaculty = faculty === "All faculties" || facultyAliases[faculty].some((alias) => normalizedFaculty.includes(alias));
			return matchesQuery && matchesFaculty;
		});
	}, [faculty, query]);

	return (
		<AppLayout setPage={setPage} activePage="programmes" showTopBar={false}>
			<div className="programme-search-page">
				<section className="search-page-heading">
					<div>
						<p className="eyebrow">Programme directory</p>
						<h1>Search programmes</h1>
						<p>Find degrees and universities that match your interests.</p>
					</div>
					<div className="search-result-count"><strong>{visibleProgrammes.length}</strong><span>matches found</span></div>
				</section>

				<section className="programme-search-panel">
					<div className="programme-search-input-wrap">
						<Search size={18} />
						<input aria-label="Search programmes" value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Search by programme, university" />
						{query && <button type="button" className="clear-search" onClick={() => setQuery("")} aria-label="Clear search">Clear</button>}
					</div>
					<button type="button" className="primary-button programme-search-button">Search <ArrowRight size={16} /></button>
				</section>

				<div className="programme-search-layout">
					<aside className="popular-search-panel">
						<div className="search-section-title">
							<div className="search-section-icon"><SlidersHorizontal size={15} /></div>
							<div><p className="eyebrow">Explore</p><h2>Popular searches</h2></div>
						</div>
						<nav className="popular-search-list" aria-label="Popular searches">
							{popularSearches.map((search) => (
								<button type="button" key={search} className={query === search ? "selected" : ""} onClick={() => setQuery(search)}>
									<span>{search}</span><ArrowRight size={14} />
								</button>
							))}
						</nav>
						
					</aside>

					<section className="search-results-panel">
						<div className="results-toolbar">
							<div><p className="eyebrow">Results</p><h2>{visibleProgrammes.length} results for “{query || "all programmes"}”</h2></div>
							<div className="filter-row">
								<label className="filter-select"><span className="sr-only">Filter by faculty</span><select value={faculty} onChange={(event) => setFaculty(event.target.value)}>{facultyOptions.map((option) => <option key={option}>{option}</option>)}</select><ChevronDown size={14} /></label>
							</div>
						</div>

						<div className="search-results-list">
							{visibleProgrammes.length > 0 ? visibleProgrammes.map((programme) => (
								<article
									className="search-programme-card"
									key={programme.id}
									tabIndex="0"
									onClick={() => setPage("programme-details", programme)}
									onKeyDown={(event) => {
										if (event.key === "Enter" || event.key === " ") setPage("programme-details", programme);
									}}
								>
									<ProgrammeLogo initials={programme.initials} tone={programme.tone} />
									<div className="search-programme-main">
										<div className="search-programme-title-row">
											<div><h3>{programme.name}</h3><p>{programme.university}</p></div>
											<button type="button" className="save-programme" aria-label={`Save ${programme.name} at ${programme.university}`} onClick={(event) => event.stopPropagation()}><Bookmark size={16} /></button>
										</div>
										<div className="search-programme-meta"><span><MapPin size={13} /> {programme.location}</span><span><Clock3 size={13} /> {programme.duration}</span><span>APS {programme.aps}</span><span>Maths {programme.maths}</span></div>
									</div>
									<div className="search-programme-action">
										<span className={`eligibility-badge ${programme.eligible ? "eligible" : "review"}`}>{programme.eligible && <CheckCircle2 size={12} />}{programme.eligible ? "Eligible" : "Review requirements"}</span>
										<button type="button" className="view-programme-button" onClick={(event) => { event.stopPropagation(); setPage("programme-details", programme); }}>View details <ArrowRight size={14} /></button>
									</div>
								</article>
							)) : <div className="empty-search-state"><Search size={22} /><h3>No programmes found</h3><p>Try a broader search or choose another faculty.</p></div>}
						</div>
					</section>
				</div>
			</div>
		</AppLayout>
	);
}
