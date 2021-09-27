export const getParameter = (param: String) => {
    let result = location.search.substr(1).split('&').find(p => p.split('=')[0] === param);
    return result ? decodeURIComponent(result.split('=')[1]) : null;
}