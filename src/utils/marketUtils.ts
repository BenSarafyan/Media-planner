/**
 * Generates a flag image URL from FlagCDN.
 * Maps 'UK' to 'gb' as FlagCDN uses ISO-3166-1 alpha-2 codes.
 */
export const getFlagUrl = (code: string, width: number = 40): string => {
  const normalizedCode = code.toUpperCase() === 'UK' ? 'gb' : code.toLowerCase();
  return `https://flagcdn.com/w${width}/${normalizedCode}.png`;
};
