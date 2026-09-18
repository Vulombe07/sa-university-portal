import { programmes } from "./programmes";

// Replace these exports with service calls when the API is available.
export const eligibilityFixture = {
  profileName: "Amina Mokoena",
  apsScore: 42,
  averageMark: 86,
  subjects: [
    { name: "Mathematics", mark: 88, level: "Level 7" },
    { name: "Physical Sciences", mark: 84, level: "Level 7" },
    { name: "English Home Language", mark: 82, level: "Level 6" },
  ],
  recommendations: [programmes[0], programmes[2], programmes[3]],
};

export const applicationsFixture = [
  { id: "app-uj-cs-2026", programme: "BSc Computer Science", institution: "University of Johannesburg", initials: "UJ", tone: "orange", submitted: "12 Aug 2026", deadline: "30 Sep 2026", status: "In progress", statusTone: "review", nextStep: "Awaiting academic review", progress: 68 },
  { id: "app-uct-it-2026", programme: "BSc Information Technology", institution: "University of Cape Town", initials: "UCT", tone: "orange", submitted: "02 Aug 2026", deadline: "30 Sep 2026", status: "In progress", statusTone: "action", nextStep: "Upload certified transcript", progress: 42 },
  { id: "app-up-cs-2026", programme: "BSc Computer Science", institution: "University of Pretoria", initials: "UP", tone: "green", submitted: "21 Jul 2026", deadline: "30 Sep 2026", status: "Submitted", statusTone: "success", nextStep: "Application submitted successfully", progress: 100 },
];

export const dashboardFixture = {
  student: { firstName: "Thabo", initials: "TM" },
  metrics: [
    { label: "Your APS", value: "42", detail: "Calculated from your marks", tone: "blue", icon: "score" },
    { label: "Eligible Programmes", value: "12", detail: "Based on your current marks", tone: "green", icon: "eligible" },
    { label: "Applications", value: "3", detail: "In progress / submitted", tone: "green", icon: "applications" },
  ],
  recommendedProgrammes: [programmes[0], programmes[1], programmes[2]],
};

export function mapDashboardResponse(response) {
  return { ...dashboardFixture, ...response };
}

export function mapEligibilityResponse(response) {
  return { ...response, recommendations: response.recommendations || [] };
}

export function mapApplicationsResponse(response) {
  return Array.isArray(response) ? response : response.applications || [];
}