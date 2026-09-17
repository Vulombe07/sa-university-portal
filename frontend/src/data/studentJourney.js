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
  { id: "app-uj-cs-2026", programme: "BSc Computer Science", institution: "University of Johannesburg", initials: "UJ", tone: "orange", submitted: "12 Aug 2026", deadline: "30 Sep 2026", status: "In review", statusTone: "review", nextStep: "Awaiting academic review", progress: 68 },
  { id: "app-uct-it-2026", programme: "BSc Information Technology", institution: "University of Cape Town", initials: "UCT", tone: "blue", submitted: "02 Aug 2026", deadline: "30 Sep 2026", status: "Action needed", statusTone: "action", nextStep: "Upload certified transcript", progress: 42 },
  { id: "app-up-cs-2026", programme: "BSc Computer Science", institution: "University of Pretoria", initials: "UP", tone: "red", submitted: "21 Jul 2026", deadline: "30 Sep 2026", status: "Offer received", statusTone: "success", nextStep: "Accept your offer by 15 Oct", progress: 100 },
];

export function mapEligibilityResponse(response) {
  return { ...response, recommendations: response.recommendations || [] };
}

export function mapApplicationsResponse(response) {
  return Array.isArray(response) ? response : response.applications || [];
}