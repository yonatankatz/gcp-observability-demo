# Networking Observability Skill Tutorial

This private repository hosts the interactive Cloud Shell tutorial for the **Google Cloud Networking Observability** skill.

## Launch the Tutorial

<p>Enter your Google Cloud Project ID below to generate your custom Cloud Shell link:</p>

<input type="text" id="projectId" placeholder="Enter Project ID..." style="padding: 5px; width: 250px;">
<button onclick="launchCloudShell()" style="padding: 6px 12px; cursor: pointer;">Open in Cloud Shell</button>

<script>
function launchCloudShell() {
    const projectId = document.getElementById('projectId').value.trim();
    if (!projectId) {
        alert("Please enter a Project ID first.");
        return;
    }
    const baseUrl = "https://ssh.cloud.google.com/cloudshell/editor";
    const repoUrl = encodeURIComponent(`https://source.developers.google.com/p/${projectId}/r/skills-tutorial`);
    const finalUrl = `${baseUrl}?cloudshell_git_repo=${repoUrl}&cloudshell_tutorial=tutorial.md&show=terminal`;
    
    window.open(finalUrl, '_blank');
}
</script>
