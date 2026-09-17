import { LayoutDashboard, UserRound, Search, ListChecks, ClipboardCheck, GraduationCap } from "lucide-react";

const items = [
  { id: "dashboard", label: "Dashboard", icon: LayoutDashboard },
  { id: "programmes", label: "Search programmes", icon: Search },
  { id: "eligibility", label: "Eligibility checker", icon: ListChecks },
  { id: "applications", label: "My applications", icon: ClipboardCheck },
   { id: "profile", label: "My profile", icon: UserRound },
];

export default function Sidebar({ setPage, activePage }) {
  return (
    <aside className="sidebar">
      <div className="sidebar-brand">
        <div className="brand-mark">
          <GraduationCap size={18} />
        </div>
        <span>UniApply</span>
      </div>

      <nav className="sidebar-nav">
        {items.map(({ id, label, icon: Icon }) => {
          const isActive = activePage === id;

          return (
            <button
              key={id}
              type="button"
              className={`nav-item ${isActive ? "active" : ""}`}
              onClick={() => setPage && setPage(id)}
            >
              <Icon size={17} />
              {label}
            </button>
          );
        })}
      </nav>
    </aside>
  );
}